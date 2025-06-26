-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/dungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self, id)
  -- function num : 0_0 , upvalues : _ENV
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if id == 0 or not id then
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
    if dialog then
      dialog:Init(sceneController)
      dialog:ItemTipsJump(nil)
    end
  else
    do
      local list = ((NekoData.BehaviorManager).BM_Game):GetDungeonList()
      local three = {}
      local found = false
      for _,data in pairs(list) do
        three = {
data = {}
, curZone = nil}
        three.curZone = id
        three.worldId = data.worldId
        three.clearZones = data.clearZones
        three.totalZones = data.totalZones
        three.isReceived = data.isReceived
        for _,d in ipairs(data.floorDetail) do
          found = found or d.floor == id
          local temp = {}
          temp.id = d.floor
          temp.spirit = d.spirit
          temp.firstGet = d.firstGet
          temp.isReceived = d.isReceived
          temp.openedBoxes = d.openedBoxes
          temp.totalBoxes = d.totalBoxes
          temp.checkPointOpenBoxex = d.checkPointOpenBoxex
          temp.checkPointTotalBoxes = d.checkPointTotalBoxes
          temp.autoExplore = d.autoExplore
          temp.smallPoint = d.smallPoint
          ;
          (table.insert)(three.data, temp)
        end
        if found then
          (table.sort)(three.data, function(a, b)
    -- function num : 0_0_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
          break
        end
      end
      if found then
        local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
        if dialog then
          dialog:Init(sceneController)
          dialog:SetTaskJump()
          dialog:ItemTipsJump({gainType = (DataCommon.GainTypeEnum).MainLine, worldId = three.worldId, 
info = {id = three.curZone}
})
        end
      else
        local recorder = ((BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")):GetRecorder(id)
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100112, {recorder.floor})
        return false
      end
      -- DECOMPILER ERROR: 7 unprocessed JMP targets
    end
  end
end

return TaskUIHandler

