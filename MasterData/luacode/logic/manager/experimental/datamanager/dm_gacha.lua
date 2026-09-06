local DM_Gacha = class("DM_Gacha")

function DM_Gacha:Ctor()
  self._gacha = NekoData.Data.gacha
  self._gacha.pools = {}
  self._gacha.convertItems = {}
  self._gacha.drawTimes = 0
  self._gacha.baodiNum = -1
end

function DM_Gacha:Clear()
  while self._gacha.pools[#self._gacha.pools] do
    table.remove(self._gacha.pools, #self._gacha.pools)
  end
  self._gacha.convertItems = {}
  self._gacha.drawTimes = 0
  self._gacha.baodiNum = -1
end

function DM_Gacha:OnSRefreshCardui(protocol)
  while self._gacha.pools[#self._gacha.pools] do
    table.remove(self._gacha.pools, #self._gacha.pools)
  end
  for k, v in pairs(protocol.pools) do
    local pool = {}
    pool.id = k
    pool.value = v
    table.insert(self._gacha.pools, pool)
  end
  self._gacha.drawTimes = protocol.drawTimes
  self._gacha.curDayTimes = protocol.curDayTimes
end

function DM_Gacha:OnSUpdateCardPools(protocol)
  while self._gacha.pools[#self._gacha.pools] do
    table.remove(self._gacha.pools, #self._gacha.pools)
  end
  for k, v in pairs(protocol.pools) do
    local pool = {}
    pool.id = k
    pool.value = v
    table.insert(self._gacha.pools, pool)
  end
end

function DM_Gacha:OnSDrawCard(items, baodiNum, shareState, curDayTimes)
  LogInfoFormat("DM_Gacha", "=====OnSDrawCard 111")
  for _, v in ipairs(items) do
    local flag = true
    for _, w in ipairs(self._gacha.convertItems) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    if flag then
      table.insert(self._gacha.convertItems, v)
    end
  end
  self._gacha.baodiNum = baodiNum
  self._gacha.shareState = shareState
  self._gacha.curDayTimes = curDayTimes
  LogInfoFormat("DM_Gacha", "=====OnSDrawCard 222")
end

function DM_Gacha:OnSBeforeDrawCard(baodiNum, shareState)
  self._gacha.baodiNum = baodiNum
  self._gacha.shareState = shareState
end

function DM_Gacha:OnSCommonGainRole(protocol)
  for _, v in ipairs(protocol.crystals) do
    local flag = true
    for _, w in ipairs(self._gacha.convertItems) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    if flag then
      table.insert(self._gacha.convertItems, v)
    end
  end
  local itemList = {}
  for _, v in ipairs(protocol.items) do
    local flag = true
    for _, w in ipairs(itemList) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    if flag then
      table.insert(itemList, v)
    end
  end
  for i, v in ipairs(itemList) do
    table.insert(self._gacha.convertItems, v)
  end
end

function DM_Gacha:SBeforeDrawCard(drawTimes)
  self._gacha.drawTimes = drawTimes
end

return DM_Gacha
