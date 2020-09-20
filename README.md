# dzp_treasure
FiveM treasure system that allows treasure spawning in any place in map and adding items to it.
<br>
### Features:
- Ability to spawn boxes anywhere in map and items to them to be looted;
- Ability to spawn vehicles anywhere in map and add key item as a requirement;
- When car is found and required key is in inventory car will be given to player's garage
### Preview:
- Preview video - [preview]
- Video of creating resourece - [creating]
### Requirements:
- `esx_vehicleshop` (only to use for cars, normal boxes will work without this)

### Installation:
1. Just download or use `git clone git@github.com:daZepelin/dzp_treasure.git`. And add it to your `resources` folder
2. To your `server.cfg` file add the following lines, which will allow you to create treasure boxes and add loot to them:
```
start dzp_treasures
add_ace group.admin dzp allow
```
or
```
start dzp_treasures
add_ace identifier.steam.<steam-64-id> dzp allow
```
3. Add `sql.sql` file query to your database.
### Usage:
After you added your permissions you can create boxes or cars. To do so use the following chat commands:<br>
`/addbox <<item1-name> <item1-amount> <item2-name> <item2-amount> ... <itemN-name> <itemN-amount>>`<br>
e.g.<br>
`/addbox beer 5 black_money 2000`<br>
> You can add as many items as you want.<br>

To add car use the same command, but as an item name use `car` (to specify car model) and `key` (to specify key needed to get the car)<br>
`/addbox car <car-model> key <key-item-name>`<br>
 e.g.<br>
 `/addbox car elegy key carkey`<br>
  
[preview]: https://youtu.be/eLz3chur5fo
[creating]: https://youtu.be/6st4I-aKsEo
