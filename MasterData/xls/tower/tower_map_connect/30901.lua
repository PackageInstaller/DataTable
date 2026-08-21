local empty = {}
return
{
  Row = 5,
  Column = 5,
  MapID = 30901,
  RoomCount = 0,
  Desc = "(支线)歌颂吾主part3",
  RoomDic = {
    [ 11 ] = {
      WindowPos = { 0.0, 0.166666672 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 1,
      LogicNum = 3090101,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 12,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 12 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 12,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 3090105,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 11,
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
      LogicNum = 3090102,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 12,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 14,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 14 ] = {
      WindowPos = { 0.140625, 0.166666672 },
      RoomNum = 14,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 4,
      LogicNum = 3090103,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 15 ] = {
      WindowPos = { 0.1875, 0.166666672 },
      RoomNum = 15,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 5,
      LogicNum = 3090104,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 14,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}