local cdungeonbufftype = {}
cdungeonbufftype.Data = {
  [1] = {
    id = 1,
    assetBundle = "sceneobjects/common.prefabs.assetbundle",
    assetName = "com_buff_01",
    pathUI = "dungeon.buff.acceleratebuffdialog",
    effectID = 1100,
    paramList = {"1.2"},
    guideID = 14
  },
  [2] = {
    id = 2,
    assetBundle = "sceneobjects/common.prefabs.assetbundle",
    assetName = "com_buff_02",
    pathUI = "dungeon.buff.invisiblebuffdialog",
    effectID = 1101,
    paramList = {},
    guideID = 15
  }
}
cdungeonbufftype.AllIds = {1, 2}
return cdungeonbufftype
