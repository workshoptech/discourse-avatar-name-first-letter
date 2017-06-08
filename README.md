## Discourse Avatar name_first_letter

Adds the ability to use `name_first_letter` in site setting `external system avatars url`.

The default value for `external system avatars url` is
    /letter_avatar_proxy/v2/letter/{first_letter}/{color}/{size}.png

This plugin allows you to use

    /letter_avatar_proxy/v2/letter/{name_first_letter}/{color}/{size}.png

to have the avatar be the first letter of the name rather than
username. If there is no name, the username is used.

To install, follow the [Install a Plugin howto](https://meta.discourse.org/t/install-a-plugin/19157?u=pfaffman).
