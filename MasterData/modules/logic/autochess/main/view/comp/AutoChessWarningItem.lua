-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessWarningItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessWarningItem", package.seeall)

local AutoChessWarningItem = class("AutoChessWarningItem", LuaCompBase)

function AutoChessWarningItem:init(go)
	self.go = go
	self.txtlevel = gohelper.findChildText(go, "#txt_level")
	self.goprogress = gohelper.findChild(go, "#go_progress")
	self.imageprogress = gohelper.findChildImage(go, "#go_progress/progressbg/#image_progress")
	self.txtexp = gohelper.findChildText(go, "#go_progress/#txt_exp")
	self.goWarningBg = gohelper.findChild(go, "image_WarningBG")
end

function AutoChessWarningItem:addEventListeners()
	self.addEventCb(self, Activity182Controller.instance, Activity182Event.UpdateInfo, self.refreshUI, self)
end

function AutoChessWarningItem:refresh(isHide)
	self.hideProgress = isHide

	self:refreshUI()
end

function AutoChessWarningItem:refreshUI()
	local actMo = Activity182Model.instance:getActMo()
	local curExp = actMo.warnExp

	self.txtlevel.text = actMo.warnLevel

	local levelCfgs = lua_auto_chess_level.configDict[actMo.activityId]

	if self.hideProgress then
		gohelper.setActive(self.goprogress, false)
		gohelper.setActive(self.goWarningBg, false)
	elseif actMo.warnLevel == #levelCfgs then
		gohelper.setActive(self.goprogress, false)
	else
		local targetExp

		for _, config in ipairs(levelCfgs) do
			if curExp < config.exp then
				targetExp = config.exp

				break
			end
		end

		if targetExp then
			self.txtexp.text = string.format("%d/%d", curExp, targetExp)
			self.imageprogress.fillAmount = curExp / targetExp
		end

		gohelper.setActive(self.goprogress, true)
	end
end

return AutoChessWarningItem
