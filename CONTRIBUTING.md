# Contributing

Thank you for helping improve the Vietnamese localization.

- Edit only the `Translation` column in `translations/*.csv`; preserve `Path`, `Key`, and `Source` exactly.
- Save as UTF-8 CSV. Keep commas, quotes, line breaks, controller tokens, markup, and placeholders intact.
- For dialogue, read neighboring lines and use the speaker/context catalog when changing pronouns or tone.
- For skills, effects, and equipment, check the description and item/ability type before changing a name. Do not invent mechanics or numeric values.
- Update `GLOSSARY.md` when a shared term changes. Record reviewed name edits in a CSV with key, old text, new text, and reason.
- Keep review batches at 500 rows or fewer and include a round-trip check in pull requests.
- Do not submit game files, save files, or a copy of the original game. Contributions to the original translation/editorial source are covered by CC BY-NC-SA 4.0.

For translation changes, include the affected keys and a short context note. For tool/build changes, include the exact command and verification result.
