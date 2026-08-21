local empty = {}
return
{
  Row = 3,
  Column = 3,
  MapID = 50105,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 5 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 5,
      uuid = 0,
      StartDir = 0,
      EndDir = 2,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 501052,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 8 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 501051,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}