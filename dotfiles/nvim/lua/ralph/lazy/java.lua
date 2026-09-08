return {
    'mfussenegger/nvim-jdtls',

    config = function ()
        -- Configure nvim-jdtls with Lombok support
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'java',
            callback = function()
                local jdtls = require('jdtls')

                local root_markers = {'pom.xml', '.git'}
                local root_dir = require('jdtls.setup').find_root(root_markers)

                if root_dir then
                    local home = os.getenv('HOME')
                    local lombok_path = home .. '/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar'
                    local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

                    local config = {
                        cmd = {
                            'java',
                            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                            '-Dosgi.bundles.defaultStartLevel=4',
                            '-Declipse.product=org.eclipse.jdt.ls.core.product',
                            '-Dlog.protocol=true',
                            '-Dlog.level=ALL',
                            '-Xms1g',
                            '--add-modules=ALL-SYSTEM',
                            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                            '-javaagent:' .. lombok_path,
                            '-jar', vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
                            '-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
                            '-data', workspace_folder
                        },
                        root_dir = root_dir,
                        settings = {
                            java = {
                                eclipse = {
                                    downloadSources = true,
                                },
                                configuration = {
                                    updateBuildConfiguration = 'interactive',
                                },
                                maven = {
                                    downloadSources = true,
                                },
                                implementationsCodeLens = {
                                    enabled = true,
                                },
                                referencesCodeLens = {
                                    enabled = true,
                                },
                                format = {
                                    enabled = true,
                                },
                            },
                        },
                        init_options = {
                            bundles = {},
                        },
                    }

                    -- Start or attach JDTLS
                    jdtls.start_or_attach(config)
                end
            end,
        })
    end
}
