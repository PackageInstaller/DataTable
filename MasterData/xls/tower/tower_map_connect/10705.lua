local empty = {}
return
{
  Row = 5,
  Column = 5,
  MapID = 10705,
  RoomCount = 0,
  Desc = "第七章上L5",
  RoomDic = {
    [ 12 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 12,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 1070501,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 13 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 1070502,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 12,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}