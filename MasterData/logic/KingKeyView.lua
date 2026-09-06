-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingKeyView.lua

module("logic.extensions.kingway.view.KingKeyView", package.seeall)

local KingKeyView = class("KingKeyView", ViewComponent)

function KingKeyView:ctor()
	KingKeyView.super.ctor(self)

	self.allKeysList = nil
	self.lineEffPos = {
		{
			x = -480,
			y = -35
		},
		{
			x = -415,
			y = -260
		},
		{
			x = 0,
			y = -320
		},
		{
			x = 425,
			y = -245
		},
		{
			x = 450,
			y = -15
		},
		{
			x = 170,
			y = 55
		},
		{
			x = -200,
			y = 70
		}
	}
	self.supCount = 0
	self.jiheCount = 0
	self.haveCount = 0
	self.allKeyEffList = nil
	self.allLineEffList = nil
end

function KingKeyView:bindEvents()
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.viewTipBtn:AddClickListener(function()
		ViewMgr.instance:open(ViewName.RulesView, "kingkey")
	end, self)
end

function KingKeyView:unbindEvents()
	self.viewCloseBtn:RemoveClickListener()
	self.viewTipBtn:RemoveClickListener()
end

function KingKeyView:buildUI()
	KingKeyView.super.buildUI(self)

	local upShowGo = self:getGo("upShowGo")

	self.viewCloseBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self.viewTipBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewTipBtn")
	self.fazhenTran = self:getGo("fazhenTran").transform

	local childCount = self.fazhenTran.childCount

	if childCount == 8 and self.allKeysList == nil then
		self.allKeysList = {}

		for i = 1, self.fazhenTran.childCount do
			local go = self.fazhenTran:GetChild(i - 1).gameObject
			local names = string.split(go.name, "_")

			self.allKeysList[tonumber(names[2])] = go:GetComponent("UIImageSpriteChange")
		end
	end
end

function KingKeyView:onEnterFinished()
	KingKeyView.super.onEnterFinished(self)
end

function KingKeyView:onExitFinished()
	return
end

function KingKeyView:onExit()
	removetimer(self.DownTimeEff, self)

	self.supCount = 0
	self.jiheCount = 0
	self.haveCount = 0
end

function KingKeyView:destroyUI()
	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	for _, eff in pairs(self.allKeyEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.allKeyEffList = nil

	for _, eff in pairs(self.allLineEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.allLineEffList = nil
	self.allKeysList = nil
end

function KingKeyView:onEnter()
	KingKeyView.super.onEnter(self)

	self.wayBaseInfo = KingWayModel.instance:GetKingInitData()

	if self.wayBaseInfo == nil then
		return
	end

	if self.allKeysList == nil or #self.allKeysList ~= self.wayBaseInfo.allKingWayCount then
		return
	end

	self.pmEff = self:CreateItemEffect(1, self.fazhenTran.gameObject)
	self.allKeyEffList = {}
	self.allLineEffList = {}

	if self.allKeysList[self.wayBaseInfo.allKingWayCount] then
		self.allKeyEffList[self.wayBaseInfo.allKingWayCount] = self:CreateItemEffect(2, self.allKeysList[self.wayBaseInfo.allKingWayCount].gameObject, self.wayBaseInfo.allKingWayCount)
	end

	self.jiheCount = self.wayBaseInfo.nowJiheKeyId

	if self.jiheCount >= self.wayBaseInfo.allKingWayCount - 1 then
		for i = 1, self.wayBaseInfo.allKingWayCount - 1 do
			if self.allKeysList and self.allKeysList[i] then
				self.allKeysList[i]:SetState(i + self.wayBaseInfo.allKingWayCount - 2)

				self.allKeyEffList[i] = self:CreateItemEffect(2, self.allKeysList[i].gameObject, i)
				self.allLineEffList[i] = self:CreateItemEffect(3, self.allKeysList[self.wayBaseInfo.allKingWayCount].gameObject, i)
			end
		end

		return
	end

	for i = 1, self.wayBaseInfo.allKingWayCount - 1 do
		if self.allKeysList and self.allKeysList[i] then
			if i <= self.jiheCount then
				self.allKeysList[i]:SetState(i + self.wayBaseInfo.allKingWayCount - 2)

				self.allKeyEffList[i] = self:CreateItemEffect(2, self.allKeysList[i].gameObject, i)
				self.allLineEffList[i] = self:CreateItemEffect(3, self.allKeysList[self.wayBaseInfo.allKingWayCount].gameObject, i)
			else
				self.allKeysList[i]:SetState(i - 1)
			end
		end
	end

	self.haveCount = self.wayBaseInfo.nowBattleId

	if self.haveCount > self.jiheCount then
		self.supCount = self.jiheCount - 1

		KingWayController.instance:CSCombinePieceReq()
		settimer(0.3, self.DownTimeEff, self, true)
	end
end

function KingKeyView:DownTimeEff()
	self.supCount = self.supCount + 1

	if self.supCount > self.haveCount then
		removetimer(self.DownTimeEff, self)

		return
	end

	if self.allKeysList and self.allKeysList[self.supCount] then
		self.allKeysList[self.supCount]:SetState(self.supCount + self.wayBaseInfo.allKingWayCount - 2)

		self.allKeyEffList[self.supCount] = self:CreateItemEffect(2, self.allKeysList[self.supCount].gameObject, self.supCount)
		self.allLineEffList[self.supCount] = self:CreateItemEffect(3, self.allKeysList[self.wayBaseInfo.allKingWayCount].gameObject, self.supCount)
	end
end

function KingKeyView:CreateItemEffect(num, parentGo, index)
	local effGo

	if num == 1 then
		local effPath = "fx_ui_wangzhezhiyao/fx_ui_wangzhezhiyao_xian.prefab"

		effGo = UIEffectManager.instance:playEffect(self, effPath, parentGo, 0, 0, true, false, nil, function(finishHandler, eff)
			local lineRdr = eff.effGo:GetComponent(typeof(UnityEngine.LineRenderer))

			if lineRdr then
				lineRdr:SetPosition(0, Vector3(0, 0, 0))
				lineRdr:SetPosition(1, Vector3(self.lineEffPos[num].x, self.lineEffPos[num].y, 0))
			end
		end, nil, self)

		local effPath = "fx_ui_wangzhezhiyao/fx_ui_wangzhezhiyao_guang.prefab"

		effGo = UIEffectManager.instance:playEffect(self, effPath, parentGo, 0, 0, true, nil, nil, nil, self)
	elseif num == 2 then
		effGo = UIEffectManager.instance:playEffect(self, (index == self.wayBaseInfo.allKingWayCount - 1 or nil) and "fx_ui_wangzhezhiyao/fx_ui_wangzhezhiyao_qiu.prefab", parentGo, 0, 0, true, nil, nil, nil, self)
	elseif num == 3 then
		local effPath = "fx_ui_wangzhezhiyao/fx_ui_wangzhezhiyao_xian.prefab"

		effGo = UIEffectManager.instance:playEffect(self, effPath, parentGo, 0, 0, true, false, nil, function(finishHandler, eff)
			local lineRdr = eff.effGo:GetComponent(typeof(UnityEngine.LineRenderer))

			if lineRdr then
				lineRdr:SetPosition(0, Vector3(0, 0, 0))
				lineRdr:SetPosition(1, Vector3(self.lineEffPos[index].x, self.lineEffPos[index].y, 0))
			end
		end, nil, self)
	end

	effGo:setParent(parentGo.transform)
	effGo:setLocalPos(0, 0, 0)
	effGo:setScale(1)

	return effGo
end

return KingKeyView
