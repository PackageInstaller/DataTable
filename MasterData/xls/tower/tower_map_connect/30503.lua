local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 30503,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 6 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 6,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 3050306,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 2,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 7 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 7,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 3050301,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 8 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 3050302,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
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
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 3050303,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 3,
          TargetRoomNum = 6,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}