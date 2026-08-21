local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local m_allList = PB.all("ItemInfo")
local m_bagList, m_mazeActivityId

function Awake()
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_bagList and m_bagList[dataIndex]
    end,
    updateSlot = OnItemShow
  })
end

function OnEnable()
  m_mazeActivityId = this:GetData("MazeActivityId")
  REF.NodeEmpty.gameObject:SetActive(false)
  this:Bind("fci/item/", OnRefreshBag)
end

function SetData(data)
  REF.ScrollView.gameObject:SetActive(false)
  OnRefreshBag(data)
end

function OnItemShow(ref, data)
  if data ~= nil then
    ref["$$SetData"](PB.enum.ResourceType.ResItem, data.id, data.count)
    ref["$$SetClickCallback"](function()
      if data.id == 92000 then
        WU.AcquireWindowAsync("ItemDetail", function(ui)
          _ENV["$"](ui)["$$SetButtonUse"](true, OnPostCure, WU.GetString("WindowItem_Use"))
          _ENV["$"](ui)["$$SetItemId"](data.id)
        end)
      else
        WU.ShowResourceDetail(PB.enum.ResourceType.ResItem, data.id)
      end
    end)
  else
    ref["$$ClearSlot"]()
  end
end

function OnRefreshBag(result)
  if result then
    m_bagList = {}
    for k, v in pairs(result) do
      local itemInfo = PB.get("ItemInfo", v.id)
      if itemInfo then
        if (itemInfo.type == PB.enum.ItemType.MazeBag or v.id == 92000) and v.count > 0 then
          table.insert(m_bagList, v)
        end
      else
        error("ItemInfo.xlsx has no this id " .. v.id)
        return
      end
    end
    REF.NodeEmpty.gameObject:SetActive(#m_bagList <= 0)
    local row = #REF.Content[0]["$"]
    LU.Set(REF.WrapContent, math.ceil(#m_bagList / row))
    REF.ScrollView.gameObject:SetActive(true)
  else
    return
  end
end

function OnPostCure(item)
  WU.TryToPay(item.type, item.id, item.count, function()
    this:GameRequest("fci/Maze/use-chaos-recovery/" .. m_mazeActivityId .. "/"):Post({
      items = {
        type = PB.enum.ResourceType.ResItem,
        id = 92000,
        count = item.count
      }
    }, function(result)
      if result then
        DBH.ResChange(result.resChange)
        local mazeInfo = DB:GetData("fci/MazeInfo/")
        mazeInfo.curChaosValue = result.chaosValue
        DB:SetData("fci/MazeInfo/", mazeInfo)
      end
    end)
  end, function()
    WU.ShowHintText(WU.GetString("Maze_NoChaosCure"))
  end)
end
