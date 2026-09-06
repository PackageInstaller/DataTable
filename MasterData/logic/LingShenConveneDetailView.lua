-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/view/LingShenConveneDetailView.lua

module("logic.extensions.lingshenconvene.view.LingShenConveneDetailView", package.seeall)

local LingShenConveneDetailView = class("LingShenConveneDetailView", ViewComponent)

function LingShenConveneDetailView:ctor()
	LingShenConveneDetailView.super.ctor(self)
end

function LingShenConveneDetailView:unbindEvents()
	LingShenConveneDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function LingShenConveneDetailView:bindEvents()
	LingShenConveneDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function LingShenConveneDetailView:buildUI()
	LingShenConveneDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._role = self:getGo("showDetail/roleCon/role")
	self._txtDesc = self:getTxt("showDetail/txtDesc")
	self._txtName = self:getTxt("showDetail/txtName")
	self._txtTitle = self:getTxt("showDetail/txtTitle")
	self._btnGoto = self:getGo("showDetail/btnGoto")
end

function LingShenConveneDetailView:onExit()
	LingShenConveneDetailView.super.onExit(self)
	uGuiUtil.clearImage(self._role)
end

function LingShenConveneDetailView:onEnter()
	LingShenConveneDetailView.super.onEnter(self)

	local params = self:getOpenParam()
	local detailId = checknumber(params[1])

	self._curCfg = LingShenConveneConfig.instance:getPetDetailCfg(detailId)

	if not GameUtil.isEmptyString(self._curCfg.lihuiResPath) then
		local path = GameUrl.getPetImgUrl(self._curCfg.lihuiResPath)

		uGuiUtil.setSpriteToImage(self._role, uGuiUtil.SpriteType.BigBg, path, function()
			self._role:GetComponent("Image"):SetNativeSize()

			self._role:GetComponent("Image").raycastTarget = false
		end)
	end

	self._txtDesc.text = self._curCfg.desc
	self._txtName.text = self._curCfg.petName
	self._txtTitle.text = langPara("%s档案", self._curCfg.petName)

	if self._curCfg then
		if not self._curCfg.jumpTo then
			local jumpToStr = ""

			goutil.setActive(self._btnGoto, not GameUtil.isEmptyString(jumpToStr))
		end
	end
end

function LingShenConveneDetailView:_onClickGoto()
	if self._curCfg then
		if not self._curCfg.jumpTo then
			local jumpToStr = ""

			self:close()

			if not GameUtil.isEmptyString(jumpToStr) then
				GotoMgr.gotoByString(jumpToStr)
			end
		end
	end
end

return LingShenConveneDetailView
