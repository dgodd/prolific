# prolific

It's like Markdown for Pivotal Tracker

This is a reimplementation of [Onsi's prolific](https://github.com/onsi/prolific) in crystal

## Usage

Build

```
crystal build src/prolific.cr
```

Run

```
./prolific help
```
or any of
```
./prolific - < stories.prolific > stories.csv
./prolific stories.prolific > stories.csv
./prolific stories.csv > stories.prolific
```

## Development

Edit the specs and implementation, then

```
crystal spec
```

## Contributing

1. Fork it ( https://github.com/dgodd/prolific/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[dgodd]](https://github.com/dgodd)  - creator, maintainer

## Thanks

- [[onsi]](https://github.com/onsi/prolific) - inspiration
