local empty = {}
return
{
  Row = 4,
  Column = 4,
  MapID = 110117,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 1 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 1,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 1,
      LogicNum = 200660200,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 2 ] = {
      WindowPos = { 0.046875, 0.0 },
      RoomNum = 2,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 2,
      LogicNum = 200660201,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 1,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}