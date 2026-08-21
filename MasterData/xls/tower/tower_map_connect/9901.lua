local empty = {}
return
{
  Row = 4,
  Column = 4,
  MapID = 9901,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 11 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 993,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 15 ] = {
      WindowPos = { 0.09375, 0.25 },
      RoomNum = 15,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 3,
      LogicNum = 992,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 16,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 16 ] = {
      WindowPos = { 0.140625, 0.25 },
      RoomNum = 16,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 4,
      LogicNum = 991,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}