local DM_GiftOfTimeMaze = class("DM_GiftOfTimeMaze")

function DM_GiftOfTimeMaze:Ctor()
  self._data = NekoData.Data.activities.giftoftimemaze
  self:Clear()
end

function DM_GiftOfTimeMaze:Clear()
  self._data.leftTime = 0
  self._data.initialTime = 0
  self._data.currentPos = 0
  if self._data.cards == nil then
    self._data.cards = {}
  else
    for key, _ in pairs(self._data.cards) do
      self._data.cards[key] = nil
    end
  end
  if self._data.blocks == nil then
    self._data.blocks = {}
  else
    for key, _ in pairs(self._data.blocks) do
      self._data.blocks[key] = nil
    end
  end
  self._data.oldCTime = 0
  self._data.nowCTime = 0
end

function DM_GiftOfTimeMaze:OnSOpenLabyrinth(protocol)
  if PrintTable then
    PrintTable(protocol, 3, "OnSOpenLabyrinth")
  end
  self._data.leftTime = protocol.leftTime
  self._data.initialTime = ServerGameTimer.GetServerTimeForecast()
  self._data.currentPos = protocol.currentPos
  for key, _ in pairs(self._data.cards) do
    self._data.cards[key] = nil
  end
  for _, value in ipairs(protocol.cards) do
    table.insert(self._data.cards, value)
  end
  for key, _ in pairs(self._data.blocks) do
    self._data.blocks[key] = nil
  end
  for key, value in pairs(protocol.blocks) do
    self._data.blocks[key] = value
  end
end

function DM_GiftOfTimeMaze:OnSRefreshMazeBlock(protocol)
  if PrintTable then
    PrintTable(protocol, 3, "OnSRefreshMazeBlock")
  end
  self._data.currentPos = protocol.pos
  for key, value in pairs(protocol.blocks) do
    self._data.blocks[key] = value
  end
end

function DM_GiftOfTimeMaze:OnSRefreshMazeCards(protocol)
  if PrintTable then
    PrintTable(protocol, 3, "OnSRefreshMazeCards")
  end
  for key, _ in pairs(self._data.cards) do
    self._data.cards[key] = nil
  end
  for _, value in ipairs(protocol.cards) do
    table.insert(self._data.cards, value)
  end
end

return DM_GiftOfTimeMaze
