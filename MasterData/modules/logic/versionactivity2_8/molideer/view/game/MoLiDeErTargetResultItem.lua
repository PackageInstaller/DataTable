-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErTargetResultItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTargetResultItem", package.seeall)

local MoLiDeErTargetResultItem = class("MoLiDeErTargetResultItem", LuaCompBase)

function MoLiDeErTargetResultItem:init(go)
	self.viewGO = go
	self._txtTarget = gohelper.findChildText(self.viewGO, "#txt_Target")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#txt_Target/#img_Icon")
	self._goIconFx = gohelper.findChild(self.viewGO, "#txt_Target/#img_Icon/#Star_ani")
	self._goTitleFx = gohelper.findChild(self.viewGO, "#txt_Target/#saoguang")
	self._goIconFx = gohelper.findChild(self.viewGO, "#txt_Target/#img_Icon/#Star_ani")
	self._goTitleFx = gohelper.findChild(self.viewGO, "#txt_Target/#saoguang")
	self._goTitleFailFx = gohelper.findChild(self.viewGO, "#txt_Target/#go_TargetFinished")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErTargetResultItem:addEventListeners()
	return
end

function MoLiDeErTargetResultItem:removeEventListeners()
	return
end

function MoLiDeErTargetResultItem:_editableInitView()
	return
end

function MoLiDeErTargetResultItem:refreshUI(desc, param, targetId, gameInfoMo, showAnim)
	local data = string.splitToNumber(param, "#")
	local type = data[1]
	local curProgress = gameInfoMo:getTargetProgress(targetId)
	local realDesc, realRound

	if type == MoLiDeErEnum.TargetType.RoundFinishAll or type == MoLiDeErEnum.TargetType.RoundFinishAny then
		realRound = MoLiDeErHelper.getRealRound(data[2], targetId == MoLiDeErEnum.TargetId.Main)
		realDesc = GameUtil.getSubPlaceholderLuaLang(desc, {
			realRound
		})
	else
		realDesc = desc
	end

	self._txtTarget.text = MoLiDeErHelper.getTargetTitleByProgress(curProgress, realDesc)

	self:refreshState(targetId, gameInfoMo, realRound, showAnim)
end

function MoLiDeErTargetResultItem:refreshState(targetId, gameInfoMo, realRound, showAnim)
	local curProgress = gameInfoMo:getTargetProgress(targetId)
	local progressState = MoLiDeErHelper.getTargetState(curProgress)

	UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageIcon, string.format("v2a8_molideer_game_targeticon_0%s_%s", targetId, progressState))

	local isSuccess = progressState == MoLiDeErEnum.ProgressChangeType.Success

	gohelper.setActive(self._goTitleFx, showAnim and isSuccess)
	gohelper.setActive(self._goIconFx, showAnim and isSuccess)

	if isSuccess and showAnim then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_gudu_input_right)
	end

	gohelper.setActive(self._goTitleFailFx, showAnim and not isSuccess)
end

function MoLiDeErTargetResultItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErTargetResultItem:onDestroy()
	return
end

return MoLiDeErTargetResultItem
