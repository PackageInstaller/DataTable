local empty = {}
return
{
  Row = 2,
  Column = 3,
  MapID = 901201,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 1 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 1,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 1,
      LogicNum = 90110,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = {
            100034
          },
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 4,
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
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 2,
      LogicNum = 90107,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 1,
          IsLocked = false,
          UnlockCondition = {
            100034
          },
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 3,
          IsLocked = false,
          UnlockCondition = {
            100034
          },
          UnlockDesc = ""
        }
      }
    },
    [ 3 ] = {
      WindowPos = { 0.09375, 0.0 },
      RoomNum = 3,
      uuid = 0,
      StartDir = 0,
      EndDir = 3,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 3,
      LogicNum = 90111,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = {
            100034
          },
          UnlockDesc = ""
        }
      }
    },
    [ 4 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 4,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 901101,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 1,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}