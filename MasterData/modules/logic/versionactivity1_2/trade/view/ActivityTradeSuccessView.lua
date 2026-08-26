-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityTradeSuccessView.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityTradeSuccessView", package.seeall)

local ActivityTradeSuccessView = class("ActivityTradeSuccessView", BaseView)

function ActivityTradeSuccessView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/main/iconbg/#simage_icon")
	self._txtaddcount = gohelper.findChildTextMesh(self.viewGO, "root/main/iconbg/#txt_addcount")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "root/main/#txt_name")
	self._txttotalget = gohelper.findChildTextMesh(self.viewGO, "root/main/bg/#txt_totalget")
	self._txtnextgoal = gohelper.findChildTextMesh(self.viewGO, "root/main/nextstage/#txt_nextgoal")
	self._gofinish = gohelper.findChild(self.viewGO, "root/main/nextstage/#txt_nextgoal/#go_finish")
	self._btnclose = gohelper.findChildClick(self.viewGO, "root/#btn_close")

	gohelper.setActive(self._gofinish, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityTradeSuccessView:addEvents()
	self._btnclose:AddClickListener(self._onClickClose, self)
end

function ActivityTradeSuccessView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ActivityTradeSuccessView:_editableInitView()
	self._simageicon:LoadImage(ResUrl.getVersionTradeBargainBg("icon/icon_tuerjiuchi"))

	self._txtname.text = luaLang("p_versionactivitytraderewardview_iconname")

	self._simagebg:LoadImage(ResUrl.getYaXianImage("img_huode_bg_2"))
end

function ActivityTradeSuccessView:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simagebg:UnLoadImage()
end

function ActivityTradeSuccessView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_fadeout)
	self:updateView()
end

function ActivityTradeSuccessView:onUpdateParam()
	self:updateView()
end

function ActivityTradeSuccessView:updateView()
	if self.viewParam then
		if not self.viewParam.score then
			local score = 0

			if self.viewParam then
				if not self.viewParam.curScore then
					local curScore = 0

					if self.viewParam then
						if not self.viewParam.nextScore then
							local nextScore = 0

							self:refreshText(score, curScore, nextScore)
						end
					end
				end
			end
		end
	end
end

function ActivityTradeSuccessView:refreshText(score, curScore, nextScore)
	self.score = score
	self.curScore = curScore
	self.nextScore = nextScore
	self._txtaddcount.text = string.format("+%s", score)
	self._txtnextgoal.text = formatLuaLang("versionactivity_1_2_tradesuccessview_nextgoal", nextScore)

	self:_refreshTotalget(true)
end

function ActivityTradeSuccessView:_refreshTotalget(tween)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if tween then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, self._tweenFrameCallback, self._tweenFinishCallback, self)
	else
		self:_setTotal(self.curScore + self.score)
	end
end

function ActivityTradeSuccessView:_tweenFrameCallback(value)
	local curScore = value * self.score + self.curScore

	self:_setTotal(curScore)
end

function ActivityTradeSuccessView:_tweenFinishCallback()
	self:_setTotal(self.curScore + self.score)
end

function ActivityTradeSuccessView:_setTotal(score)
	local curScore = math.floor(score)
	local color = curScore >= self.nextScore and "#B9FF80" or "#D9A06F"
	local tag = {
		color,
		curScore
	}

	self._txttotalget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_1_2_tradesuccessview_totalget"), tag)

	gohelper.setActive(self._gofinish, curScore >= self.nextScore)
end

function ActivityTradeSuccessView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function ActivityTradeSuccessView:_onClickClose()
	self:closeThis()
end

return ActivityTradeSuccessView
