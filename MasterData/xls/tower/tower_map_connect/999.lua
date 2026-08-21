local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 999,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 14 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 14,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 14,
      RowNum = 0,
      ColumnNum = 0,
      LogicNum = 0,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 15 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 15,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 14,
      RowNum = 0,
      ColumnNum = 0,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 14,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 16,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 16 ] = {
      WindowPos = { 0.140625, 0.166666672 },
      RoomNum = 16,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 14,
      RowNum = 0,
      ColumnNum = 0,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 17,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 17 ] = {
      WindowPos = { 0.1875, 0.166666672 },
      RoomNum = 17,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 14,
      RowNum = 0,
      ColumnNum = 0,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 16,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 18,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 18 ] = {
      WindowPos = { 0.234375, 0.166666672 },
      RoomNum = 18,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 14,
      RowNum = 0,
      ColumnNum = 0,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 17,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}