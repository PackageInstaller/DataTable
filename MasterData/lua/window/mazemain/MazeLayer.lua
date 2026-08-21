local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local CO = require("Common/Coroutine")
local m_buffRowList, m_map, m_mazeInfo, m_mazeId, m_mazeActivityId

function Awake()
end

function Start()
end

function Clean()
  for i, v in ipairs(m_map) do
    this:Unbind("MazeCellData" .. i, SetMazeCell)
  end
end

function OnEnable()
  REF.SkeletonActor.gameObject:SetActive(false)
end

function ClearCache()
  local data = m_mazeInfo
  for row = 1, data.mazeMapDimension do
    for col = 1, data.mazeMapDimension do
      local index = (row - 1) * data.mazeMapDimension + col
      this:SetData("MazeCellData" .. index, nil)
      this:SetData("MazeCellDataPlayTween" .. index, nil)
    end
  end
end

function SetData(data, init)
  local isFirstTweenOn = this:GetData("MazeFirstTweenOn")
  REF.ActorMove.transform.localScale = CS.UnityEngine.Vector3.one
  if isFirstTweenOn then
    REF.ActorMove.transform.localScale = CS.UnityEngine.Vector3.zero
    this:DelayInvokeInSeconds(1.6, function()
      REF.ActorMove.transform.localScale = CS.UnityEngine.Vector3.one
    end)
  end
  m_mazeActivityId = this:GetData("MazeActivityId")
  m_mazeId = this:GetData("fci/MazeId/" .. m_mazeActivityId .. "/")
  m_mazeInfo = data
  m_map = {}
  for row = 1, data.mazeMapDimension do
    for col = 1, data.mazeMapDimension do
      local index = (row - 1) * data.mazeMapDimension + col
      local cellSlotData = {}
      local cellData = data.mazeCells[index]
      cellSlotData.data = cellData
      cellSlotData.index = index
      if cellData == nil then
        cellSlotData.isEnd = false
        cellSlotData.isStart = false
      else
        cellSlotData.isEnd = cellData.nextCellIndex == 0 and cellData.preCellIndex ~= 0 and cellData.branchIndex == 0
        cellSlotData.isStart = cellData.nextCellIndex ~= 0 and cellData.preCellIndex == 0 and cellData.branchIndex == 0
      end
      cellSlotData.nextCell = {}
      m_map[index] = cellSlotData
      this:SetData("MazeCellData" .. index, cellSlotData)
    end
  end
  for i, v in pairs(m_map) do
    if v.data and 0 < v.data.preCellIndex then
      local cell = m_map[v.data.preCellIndex]
      cell.nextCell[#cell.nextCell + 1] = v
    end
  end
  for i, v in ipairs(m_map) do
    this:SetData("MazeCellData" .. i, v)
    if init == true then
      if isFirstTweenOn == true then
        if v.data then
          this:SetData("MazeCellHasPlayTween" .. i, false)
          this:SetData("MazeCellLineHasPlayTween" .. i, false)
        else
          this:SetData("MazeCellHasPlayTween" .. i, nil)
          this:SetData("MazeCellLineHasPlayTween" .. i, nil)
        end
      elseif v.data then
        if v.data.isPassed == true then
          this:SetData("" .. i, true)
        elseif not v.data.isPassed and m_map[v.data.preCellIndex].data and m_map[v.data.preCellIndex].data.isPassed == true then
          this:SetData("MazeCellHasPlayTween" .. i, true)
          this:SetData("MazeCellLineHasPlayTween" .. i, true)
        elseif not v.data.isPassed then
          this:SetData("MazeCellHasPlayTween" .. i, false)
          this:SetData("MazeCellLineHasPlayTween" .. i, false)
        end
      else
        this:SetData("MazeCellHasPlayTween" .. i, nil)
        this:SetData("MazeCellLineHasPlayTween" .. i, nil)
      end
    end
  end
  for i, v in ipairs(m_map) do
    this:Unbind("MazeCellData" .. i, SetMazeCell)
    this:Bind("MazeCellData" .. i, SetMazeCell)
  end
end

function SetMazeCell(cellSlotData)
  if cellSlotData == nil then
    return
  end
  local index = cellSlotData.index
  local refCellSlot = _ENV["$"](REF[string.format("Slot%d", index)])
  refCellSlot.MazeLayerSlot["$SetData"](cellSlotData)
end
