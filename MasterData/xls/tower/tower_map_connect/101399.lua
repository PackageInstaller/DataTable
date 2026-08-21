local empty = {}
return
{
  Row = 1,
  Column = 4,
  MapID = 101399,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 5 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 5,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 1,
      LogicNum = 10139901,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 6,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 6 ] = {
      WindowPos = { 0.046875, 0.0 },
      RoomNum = 6,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 2,
      LogicNum = 10139902,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 7 ] = {
      WindowPos = { 0.09375, 0.0 },
      RoomNum = 7,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 3,
      LogicNum = 10139903,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 6,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 8 ] = {
      WindowPos = { 0.140625, 0.0 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 4,
      LogicNum = 10139904,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}