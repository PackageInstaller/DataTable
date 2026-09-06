-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonDropTipsView.lua

module("logic.extensions.common.instruction.view.CommonDropTipsView", package.seeall)

local CommonDropTipsView = class("CommonDropTipsView", ViewComponent)

function CommonDropTipsView:ctor()
	CommonDropTipsView.super.ctor(self)
end

function CommonDropTipsView:destroyUI()
	CommonDropTipsView.super.destroyUI(self)
end

function CommonDropTipsView:onExitFinished()
	CommonDropTipsView.super.onExitFinished(self)
end

function CommonDropTipsView:onEnterFinished()
	CommonDropTipsView.super.onEnterFinished(self)
end

function CommonDropTipsView:unbindEvents()
	CommonDropTipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function CommonDropTipsView:bindEvents()
	CommonDropTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CommonDropTipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function CommonDropTipsView:onExit()
	CommonDropTipsView.super.onExit(self)
	self.tableView:dispose()
	removetimer(self._timer, self)
end

function CommonDropTipsView:buildUI()
	CommonDropTipsView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)

	local _Nego_Top = goutil.findChild(self._Nego_Content, "Nego_Top")

	self._TxtC_Name = goutil.findChild(_Nego_Top, "TxtC_Name"):GetComponent("Text")
	self._TxtC_Count = goutil.findChild(_Nego_Top, "TxtC_Count"):GetComponent("Text")
	self._ImgC_Con = goutil.findChild(_Nego_Top, "ImgC_Con")
	self.imgBg = goutil.findChildComponent(_Nego_Top, "ImgC_TxtBg", "UIChangeGroup")
	self.cell = self:getGo("Nego_Content/Nego_Bottom/List/cell")
	self.ScrollView = self:getGo("Nego_Content/Nego_Bottom/List/ScrollView")
	self.tableView = ScrollerList.create(self.ScrollView, self.cell, GameUtil.handler(self.onUpdateCell, self), GameUtil.handler(self.onClearCell, self))
	self._TxtC_Count.text = lang("有概率获得以下道具")
end

function CommonDropTipsView:onEnter()
	CommonDropTipsView.super.onEnter(self)

	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		local data = self._viewPresentor._openParam[1]

		MaterialMgr.resetAll(self._ImgC_Con)
		self.imgBg:SetState(0)

		self._TxtC_Name.text = lang("掉落宝箱")
		self._TxtC_Count.text = lang("可概率获得以下道具：")

		self:setIcon(data)

		local cfg = MaterialMgr.getMatCfg(data.type, data.id)

		if cfg then
			if cfg.name then
				self._TxtC_Name.text = cfg.name
			end

			if cfg.groupName then
				self._TxtC_Name.text = cfg.groupName
			end

			if not string.nilorempty(cfg.des) then
				self._TxtC_Count.text = cfg.des
			end

			if not string.nilorempty(cfg.desc) then
				self._TxtC_Count.text = cfg.desc
			end

			if data.type == MatType.EmojiPack then
				self._TxtC_Count.text = lang("可以获得以下物品")
			end

			self.imgBg:SetState((cfg.quality or 0) + 1)

			local arr = cfg.rewardPreview and MaterialMgr.changeItemStrArr(cfg.rewardPreview) or {}

			self.tableView:reloadData(arr)
		end

		if pos then
			GameUtil.SetActive(self.mainGO, false)
			settimer(0.1, self._timer, self, false)
		else
			Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
		end
	end
end

function CommonDropTipsView:_timer()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)

	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		self._adjustPosition:AdjustScreenPosition(pos, self._viewPresentor._openParam[3][1], self._viewPresentor._openParam[3][2])
	end
end

function CommonDropTipsView:onUpdateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local proxy = MaterialMgr.setCellByCfg(data, con)
	local matType, matId, matNum = MaterialMgr.getMatParams(data)

	if proxy then
		if matType == MatType.Item and CutePetConfig.instance:isIllusionCard(matId) == true then
			local raceId = checknumber(CutePetConfig.instance:getIllusionCardCutePet(matId))
			local raceInfo = CutePetModel.instance:getCuteSuitInfo(raceId)

			if raceInfo then
				if not raceInfo.unLocked then
					local hasTag = false
					local withState = hasTag and 1 or 0

					proxy.binder:setWithTag(withState)
				end
			end
		elseif matType == MatType.Item or MaterialMgr.SkinPrizeCheckTypes[matType] then
			local isWith = MaterialMgr.isWithInSkinPrize(matType, matId)
			local withState = isWith and 1 or 0

			proxy.binder:setWithTag(withState)
		end
	end
end

function CommonDropTipsView:onClearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function CommonDropTipsView:setIcon(data)
	local proxy = MaterialMgr.setCell(data.type, data.id, self._ImgC_Con)

	proxy:setAutoTips(false)

	return proxy
end

return CommonDropTipsView
