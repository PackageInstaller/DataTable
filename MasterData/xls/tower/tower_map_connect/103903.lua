local empty = {}
return
{
  Row = 3,
  Column = 4,
  MapID = 103903,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 3 ] = {
      WindowPos = { 0.09375, 0.0 },
      RoomNum = 3,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 11,
      RowNum = 1,
      ColumnNum = 3,
      LogicNum = 10390313,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 7 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 7,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 10390306,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 3,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 9 ] = {
      WindowPos = { 0.0, 0.166666672 },
      RoomNum = 9,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 1,
      LogicNum = 10390301,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 10 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 10,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 10390302,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 9,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 11 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 10390303,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 10,
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
        }
      }
    }
  }
}