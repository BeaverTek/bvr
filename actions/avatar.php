<?php
/**
 * Retrieve user avatar by nickname action class.
 *
 * PHP version 5
 *
 * @category Action
 * @package  StatusNet
 * @author   Evan Prodromou <evan@status.net>
 * @author   Robin Millette <millette@status.net>
 * @license  http://www.fsf.org/licensing/licenses/agpl.html AGPLv3
 * @link     http://status.net/
 *
 * StatusNet - the distributed open-source microblogging tool
 * Copyright (C) 2008, 2009, StatusNet, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (!defined('GNUSOCIAL')) { exit(1); }

/**
 * Retrieve user avatar by nickname action class.
 *
 * @category Action
 * @package  GNUsocial
 * @author   Evan Prodromou <evan@status.net>
 * @author   Robin Millette <millette@status.net>
 * @author   Mikael Nordfeldth <mmn@hethane.se>
 * @author   Hugo Sales <hugo@fc.up.pt>
 * @license  http://www.fsf.org/licensing/licenses/agpl.html AGPLv3
 * @link     http://www.gnu.org/software/social/
 */
class AvatarAction extends Action
{
    public $filename = null;
    protected function prepare(array $args = [])
    {
        parent::prepare($args);
        if (empty($this->filename = $this->trimmed('file'))) {
            // TRANS: Client error displayed trying to get a non-existing avatar.
            $this->clientError(_m('No such avatar.'), 404);
        }
        return true;
    }

    protected function handle()
    {
        parent::handle();

        if (is_string($srv = common_config('avatar', 'server')) && $srv != '') {
            common_redirect(Avatar::url($this->filename), 302);
        } else {
            $attachment = new AttachmentAction(); // kludge...
            $attachment->filepath = common_config('avatar', 'dir') . $this->filename;
            $attachment->sendFile();
        }
        return true;
    }
}
