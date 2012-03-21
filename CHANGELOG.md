# CHANGELOG #

## 0.1.0 ##

* New feature: api instance can be set to not wrap raw response within objects with: `@api.set\_object\_wrapping(false)`

## 0.0.5 ##

* Fixed: IActionable::Objects::Awardable#awarded_on was stripping out time information when converting IActionable timestamp to Ruby time object

## 0.0.4 ##

* explicitly rescuing from timeout errors.

## 0.0.3 ##

* Gem name matches require string.

## 0.0.2 ##

* Gem name matches require string.

## 0.0.1 ##

* Pulling API wrapper out as separate gem (this).