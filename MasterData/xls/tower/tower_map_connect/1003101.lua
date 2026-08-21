local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 1003101,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 11 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 3,
      EndDir = 1,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 1311,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 12,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}