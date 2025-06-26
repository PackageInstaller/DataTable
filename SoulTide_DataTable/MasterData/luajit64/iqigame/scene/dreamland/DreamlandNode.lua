-- chunkname: @IQIGame\\Scene\\Dreamland\\DreamlandNode.lua

local m = {
	CellCid = 0,
	IndexY = 0,
	IndexX = 0
}
local DreamlandNodeSubViewController = require("IQIGame.Scene.Dreamland.DreamlandNodeSubViewController")

function m.New(view, cellCid, indexX, indexY)
	local obj = Clone(m)

	obj:Init(view, cellCid, indexX, indexY)

	return obj
end

function m:Init(view, cellCid, indexX, indexY)
	self.View = view
	self.CellCid = cellCid
	self.IndexX = indexX
	self.IndexY = indexY

	LuaCodeInterface.BindOutlet(self.View, self)

	self.Bad = DreamlandNodeSubViewController.New(self.BadView)
	self.Good = DreamlandNodeSubViewController.New(self.GoodView)
end

function m:__SetData(cellPOD)
	self.CellPOD = cellPOD

	if self.CellPOD.dataId == 0 then
		self.UnknownView:SetActive(true)
		self.Bad:SetActive(false)
		self.Good:SetActive(false)

		return
	end

	local cfgDreamMapCellDataData = CfgDreamMapCellDataTable[self.CellPOD.dataId]
	local isOpen = self.CellPOD.isOpen
	local isFinalShowType = self.CellPOD.showType or isOpen

	self.UnknownView:SetActive(not isFinalShowType)
	self.Bad:SetActive(isFinalShowType and cfgDreamMapCellDataData.Type == 0)
	self.Good:SetActive(isFinalShowType and cfgDreamMapCellDataData.Type == 1)

	if self.MarkView ~= nil then
		self.MarkView:SetActive(self.CellPOD.markType == 1)
	end

	local num = 0

	if isOpen then
		local aroundCellPODs = DreamlandModule.GetAroundCellPODs(self.IndexX, self.IndexY)

		for i = 1, #aroundCellPODs do
			local aroundCellPOD = aroundCellPODs[i]

			if aroundCellPOD.dataId ~= 0 then
				local aroundNodeCellData = CfgDreamMapCellDataTable[aroundCellPOD.dataId]

				if aroundNodeCellData.Type == cfgDreamMapCellDataData.Type then
					num = num + 1
				end
			end
		end
	end

	self.Bad:SetData(isOpen, num)
	self.Good:SetData(isOpen, num)
	EventDispatcher.Dispatch(EventID.DreamlandRefreshCellData, self.CellPOD.x, self.CellPOD.y)
end

function m:GetPos()
	return self.View.transform.position:Clone()
end

function m:GetHeroNodePos()
	return self.HeroNode.transform.position:Clone()
end

function m:GetNpcNodePos()
	return self.NpcNode.transform.position:Clone()
end

function m:GetFaceToNpcDir()
	return self.NpcNode.transform.position.x - self.HeroNode.transform.position.x
end

function m:PlayOpenCell()
	local cfgDreamMapCellDataData = CfgDreamMapCellDataTable[self.CellPOD.dataId]
	local effectCid, soundCid

	if cfgDreamMapCellDataData.Type == 1 then
		effectCid = 2010001
		soundCid = 10526
	else
		effectCid = 2010002
		soundCid = 10525
	end

	self:PlayEffectOnRoot(effectCid)
	GameEntry.Sound:PlaySound(soundCid, Constant.SoundGroup.ENVIRONMENT)
end

function m:PlayShowCellType()
	self:PlayEffectOnRoot(2010005)
	GameEntry.Sound:PlaySound(10524, Constant.SoundGroup.ENVIRONMENT)
end

function m:PlayEffectOnRoot(effectCid)
	GameEntry.Effect:PlayMountPointEffect(effectCid, Constant.MountPoint.PointRoot, 0, self.View, 0, 0, 0, LuaCodeInterface.SortingLayerNameToID("Element"), 2, 1, true)
end

function m:Dispose()
	self.Bad:Dispose()
	self.Good:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
