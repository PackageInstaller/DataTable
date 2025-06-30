-- chunkname: @IQIGame\\UI\\Story\\Maze\\MazeSmallMapItemView.lua

local MazeSmallMapItemView = {}

function MazeSmallMapItemView.New(mainView)
	local o = Clone(MazeSmallMapItemView)

	o.mainView = mainView

	return o
end

function MazeSmallMapItemView:Initialize(go, roomID)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.roomID = roomID

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeSmallMapItemView:InitComponent()
	self.transform = self.gameObject.transform
end

function MazeSmallMapItemView:InitDelegate()
	return
end

function MazeSmallMapItemView:AddListener()
	return
end

function MazeSmallMapItemView:RemoveListener()
	return
end

function MazeSmallMapItemView:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function MazeSmallMapItemView:Show()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.roomHide, true)
end

function MazeSmallMapItemView:Hide()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.roomHide, false)
end

function MazeSmallMapItemView:GetTransform()
	return self.transform
end

function MazeSmallMapItemView:GetPosition()
	return self.transform.position
end

function MazeSmallMapItemView:SetPlayerIn()
	LuaUtility.SetGameObjectShow(self.mapImg, false)
	LuaUtility.SetGameObjectShow(self.mapImg_Now, true)
end

function MazeSmallMapItemView:SetPlayerOut()
	LuaUtility.SetGameObjectShow(self.mapImg, true)
	LuaUtility.SetGameObjectShow(self.mapImg_Now, false)
end

function MazeSmallMapItemView:SetRoomArrived()
	LuaUtility.SetGameObjectShow(self.imageHasIn, true)
end

function MazeSmallMapItemView:SetRoomNotArrived()
	LuaUtility.SetGameObjectShow(self.imageHasIn, false)
end

function MazeSmallMapItemView:Refresh()
	LuaUtility.SetGameObjectShow(self.boxItem, false)
	LuaUtility.SetGameObjectShow(self.monsterItem, false)
	LuaUtility.SetGameObjectShow(self.eliteMonsterItem, false)

	if not self.roomID or self.roomID == 0 then
		return
	end

	if self.mainView:GetLastInRoomID() == self.roomID then
		self:SetPlayerIn()
	else
		self:SetPlayerOut()
	end

	if MazeStageModule.GetRoomIsArrived(self.roomID) then
		self:SetRoomArrived()
	else
		self:SetRoomNotArrived()
	end

	local cfg = CfgUtil.GetCfgMazeRoomDataWithID(self.roomID)
	local len = #cfg.Event

	for i = 1, len do
		local cfgEvent = CfgUtil.GetCfgMazeEventDataWithID(cfg.Event[i])

		if cfgEvent.Type == Constant.MazeEventDefine.Box then
			LuaUtility.SetGameObjectShow(self.boxItem, true)
		elseif cfgEvent.Type == Constant.MazeEventDefine.BoostMonster then
			LuaUtility.SetGameObjectShow(self.monsterItem, true)
		elseif cfgEvent.Type == Constant.MazeEventDefine.Boss then
			LuaUtility.SetGameObjectShow(self.eliteMonsterItem, true)
		end
	end
end

return MazeSmallMapItemView
