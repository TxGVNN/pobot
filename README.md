# Pobot ![tool](https://img.shields.io/:tool-pobot-blue.svg)
`pobot`: The simple tool helps to translate po file in the projects on Debian project.

*Please check by your eyes and use `msgfmt` to check again*

### How to install?
- [Translate shell](https://github.com/soimort/translate-shell)

  Please install `translate-shell`
- Then, clone and run

  Or: 
  
  `wget https://raw.githubusercontent.com/Debian-VN/pobot/master/pobot.pl -O /usr/bin/pobot.pl`

### How to use?

```
Usage:  pobot.pl -i <input-file> [-o output-file] [-l srclang:dstlang]

```
*Example*

```
pobot.pl -i 01_the-debian-project.po -o 01_the-debian-project.po.vi
```

### Changelog

- v2
```
- Replace pobot (bash) to pobot.pl (written by Perl)
- Process tag-xml before translate
```

- v1 (commit @b1ace84)
```
- Just tool to suggest to translate => Not done
- Doesn't process tag-xml
```
