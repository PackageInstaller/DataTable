-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbchooseView.lua

module("logic.extensions.fbbchallenge.view.FbbchooseView", package.seeall)

local FbbchooseView = class("FbbchooseView", ViewComponent)

function FbbchooseView:ctor()
	FbbchooseView.super.ctor(self)
end

function FbbchooseView:buildUI()
	FbbchooseView.super.buildUI(self)

	self._btnBuff = self:getBtn("btnBuff")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtEffect = goutil.findChildTextComponent(self.mainGO, "txtEffect")
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "txtLevel")
	self._buffGo = self:getGo("buff")
end

function FbbchooseView:bindEvents()
	FbbchooseView.super.bindEvents(self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
end

function FbbchooseView:unbindEvents()
	FbbchooseView.super.unbindEvents(self)
	self._btnBuff:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function FbbchooseView:destroyUI()
	FbbchooseView.super.destroyUI(self)
end

function FbbchooseView:onEnter()
	FbbchooseView.super.onEnter(self)

	self._info = FbbchallengeModel.instance:getClgInfo()

	self:_updateBuffUI()
end

function FbbchooseView:onEnterFinished()
	FbbchooseView.super.onEnterFinished(self)
end

function FbbchooseView:onExit()
	FbbchooseView.super.onExit(self)
	uGuiUtil.clearImage(self._buffGo)
end

function FbbchooseView:onExitFinished()
	FbbchooseView.super.onExitFinished(self)
end

function FbbchooseView:_onClickbtnBuff()
	FbbchallengeController.instance:gotoPlaySamallGame()
	self:close()
end

function FbbchooseView:_onClickbtnChallenge()
	local function okFunc()
		UIStateManager.instance:push(ViewName.FbbmissionView)
		self:close()
	end

	if not self._hasBuff then
		local title = "提示"
		local content = "今日还未通过月黑风高获得高级战意\n是否继续挑战"
		local okBtnStr = "继续挑战"
		local cancelBtnStr = "取消"

		UIStateManager.instance:push(ViewName.FbbgametipView, title, content, okFunc, nil, okBtnStr, cancelBtnStr)
	else
		okFunc()
	end
end

function FbbchooseView:_updateBuffUI()
	if not self._info then
		return
	end

	self._hasBuff = self._info.bestshovelNums > 0

	local cfg = FbbchallengeModel.instance:getBuffCfg(self._info.bestshovelNums)

	self._txtLevel.text = "当前战意：Lv." .. cfg.grade
	self._txtEffect.text = cfg.desc

	uGuiUtil.setSpriteToImage(self._buffGo, nil, GameUrl.getIconFolderUrl("expevents", cfg.buffKey))
end

return FbbchooseView
