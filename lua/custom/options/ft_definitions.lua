vim.filetype.add {
  extension = {
    pgsql = 'sql',
  },
  filename = {
    -- ['.env'] = 'dotenv',
  },
  pattern = {
    ['.*/roles/.*%.ya?ml'] = 'yaml.ansible',
    ['.*ansible.*/main%.ya?ml'] = 'yaml.ansible',
    ['.*ansible.*playbooks.*/*%.ya?ml'] = 'yaml.ansible',
    ['compose.ya?ml'] = 'yaml.docker-compose',
    ['docker%-compose%.ya?ml'] = 'yaml.docker-compose',
    ['.*.env'] = 'dotenv',
  },
}
