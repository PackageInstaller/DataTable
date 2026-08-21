local empty = {}
return
{
  Row = 3,
  Column = 2,
  MapID = 101052,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 4 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 4,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 1532,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 4,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 5 ] = {
      WindowPos = { 0.0, 0.166666672 },
      RoomNum = 5,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 1,
      LogicNum = 1531,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 3,
          TargetRoomNum = 4,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}