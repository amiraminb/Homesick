# Changelog

## [0.3.0](https://github.com/amiraminb/Homesick/compare/v0.2.0...v0.3.0) (2026-06-14)


### Features

* theme nvim-bqf quickfix preview windowDefine BqfPreviewFloat/Border/Title using the same float_bg as theTelescope preview, so the quickfix preview reads as a distinct floatingpanel instead of inheriting NormalFloat and blending into the editor.Wired as a new opt-in-by-default 'bqf' integration. ([#6](https://github.com/amiraminb/Homesick/issues/6)) ([9faf86b](https://github.com/amiraminb/Homesick/commit/9faf86bd5c004893abe8fa2b7321338f9610bbe6))

## [0.2.0](https://github.com/amiraminb/Homesick/compare/v0.1.0...v0.2.0) (2026-06-14)


### Features

* dim whole editor when Neovim loses focusAdd an opt-in focus_dim option that repaints Normal with the inactiveNormalNC background on FocusLost and restores it on FocusGained, so theeditor visibly dims when focus moves to another tmux pane or window.Colors are read live from the highlight groups, so variant switches arepicked up automatically via the ThemeApplied autocmd. Defaults to off. ([#4](https://github.com/amiraminb/Homesick/issues/4)) ([a280ab6](https://github.com/amiraminb/Homesick/commit/a280ab6f424c349a8bff823dba5fa53bfa87973b))

## 0.1.0 (2026-05-14)


### Features

* add neo-tree integration ([524b551](https://github.com/amiraminb/Homesick/commit/524b551690e095641f5ac68f7b0f478f05a3cbe7))
* add neo-tree integration ([4a2d000](https://github.com/amiraminb/Homesick/commit/4a2d000d7c7d28873ee5ed9869f69b368fa3aa33))
* change couple of stuff for moon variant ([08b770f](https://github.com/amiraminb/Homesick/commit/08b770fdf660dc405bb94bdd6483aa72645b9d64))
* change matching chars colors in moon version ([3ef8816](https://github.com/amiraminb/Homesick/commit/3ef8816f73362a3cf7a90a47bf24f77abd9089e3))
* Update diff colors ([5ca842a](https://github.com/amiraminb/Homesick/commit/5ca842a659bec29bd2ca66c690e10a8f0f58cebe))
* Update LspReferenceText ([d0b7825](https://github.com/amiraminb/Homesick/commit/d0b7825565aac9a3ccd919002d63bdd918b76249))
* Update LspReferenceText ([ced1a86](https://github.com/amiraminb/Homesick/commit/ced1a8662fc8eaeb749bf49e772135718a78a3d7))


### Bug Fixes

* align IlluminatedWord highlight with LspReferenceText colors ([b539711](https://github.com/amiraminb/Homesick/commit/b53971195883c126906695d013e3341140928d33))
* bufferline highlight consistency and palette cleanup ([de184ea](https://github.com/amiraminb/Homesick/commit/de184ea140c4683796da88e15bca40882d18cbef))
* bug ([b70880b](https://github.com/amiraminb/Homesick/commit/b70880b035323a943e08be4212bfbca6fd2d2032))


### Miscellaneous Chores

* pin first release at 0.1.0 ([e929ed6](https://github.com/amiraminb/Homesick/commit/e929ed640493655c0849491529e5cc42a488b69a))
