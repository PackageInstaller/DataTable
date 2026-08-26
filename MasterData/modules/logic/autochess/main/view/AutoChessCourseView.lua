-- chunkname: @modules/logic/autochess/main/view/AutoChessCourseView.lua

module("modules.logic.autochess.main.view.AutoChessCourseView", package.seeall)

local AutoChessCourseView = class("AutoChessCourseView", BaseView)

function AutoChessCourseView:onInitView()
	self._goBadge = gohelper.findChild(self.viewGO, "root/#go_Badge")
	self._txtAllWinCnt = gohelper.findChildText(self.viewGO, "root/right/item1/#txt_AllWinCnt")
	self._txtPlayRound = gohelper.findChildText(self.viewGO, "root/right/item2/#txt_PlayRound")
	self._txtAllDamage = gohelper.findChildText(self.viewGO, "root/right/item3/#txt_AllDamage")
	self._txtChessCnt = gohelper.findChildText(self.viewGO, "root/right/item4/#txt_ChessCnt")
	self._goChessItem = gohelper.findChild(self.viewGO, "root/right/Chess/scroll_Chess/viewport/content/#go_ChessItem")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCourseView:addEvents()
	return
end

function AutoChessCourseView:removeEvents()
	return
end

function AutoChessCourseView:_editableInitView()
	self.actMo = Activity182Model.instance:getActMo()
end

function AutoChessCourseView:onUpdateParam()
	return
end

function AutoChessCourseView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)

	local info = self.actMo.historyInfo
	local badgeGo = self:getResInst(AutoChessStrEnum.ResPath.BadgeItem, self._goBadge)
	local badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(badgeGo, AutoChessBadgeItem, self)

	badgeItem:setData(info.maxRank, 99999, AutoChessBadgeItem.ShowType.CourseView)

	self._txtAllWinCnt.text = info.winCount
	self._txtPlayRound.text = info.survivalTotalRound
	self._txtAllDamage.text = info.totalHurt

	local chessArr = GameUtil.splitString2(info.autoChessCount, true)

	if chessArr then
		table.sort(chessArr, function(a, b)
			return a[2] > b[2]
		end)

		for _, data in ipairs(chessArr) do
			local config = AutoChessConfig.instance:getChessCfg(data[1])

			if config then
				local go = gohelper.cloneInPlace(self._goChessItem)
				local imageBg = gohelper.findChildImage(go, "image_Bg")
				local resName = AutoChessHelper.getChessQualityBg(config.type, config.levelFromMall)

				UISpriteSetMgr.instance:setAutoChessSprite(imageBg, resName)

				local meshGo = gohelper.findChild(go, "Mesh")
				local meshItem = MonoHelper.addNoUpdateLuaComOnceToGo(meshGo, AutoChessMeshComp)

				meshItem:setData(config.image)
				gohelper.setActive(go, true)
			end
		end

		self._txtChessCnt.text = #chessArr
	else
		self._txtChessCnt.text = 0
	end
end

function AutoChessCourseView:onClose()
	return
end

function AutoChessCourseView:onDestroyView()
	return
end

return AutoChessCourseView
