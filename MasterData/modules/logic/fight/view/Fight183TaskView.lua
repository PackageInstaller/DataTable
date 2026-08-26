-- chunkname: @modules/logic/fight/view/Fight183TaskView.lua

module("modules.logic.fight.view.Fight183TaskView", package.seeall)

local Fight183TaskView = class("Fight183TaskView", FightBaseView)

function Fight183TaskView:onInitView()
	self._titleText = gohelper.findChildText(self.viewGO, "#txt_title")
	self._descText = gohelper.findChildText(self.viewGO, "#txt_dec")
end

function Fight183TaskView:addEvents()
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
end

function Fight183TaskView:removeEvents()
	return
end

function Fight183TaskView:onConstructor(condition)
	local configId = string.splitToNumber(condition, "#")[1]

	self._config = lua_challenge_condition.configDict[configId]
end

function Fight183TaskView:onOpen()
	self:_refreshData()
end

function Fight183TaskView:_onBuffUpdate(entityId, effectType, buffId)
	if not self._config then
		return
	end

	if entityId ~= FightEntityScene.MySideId then
		return
	end

	self:_refreshData()
end

function Fight183TaskView:_refreshData()
	if self._config then
		local config = self._config
		local finish = false

		if config.type == 19 then
			local tarBuffId = tonumber(config.value)
			local vertin = FightDataHelper.entityMgr:getMyVertin()

			if vertin then
				for k, v in pairs(vertin.buffDic) do
					if v.buffId == tarBuffId then
						finish = true

						break
					end
				end
			end
		end

		local name = ""
		local desc = config.decs1

		if finish then
			local nameStr = luaLang("act183task_condition_title_complete")

			name = string.format("<color=#7A8E51>%s</color>", nameStr)
			desc = string.format("<s><color=#7A8E51>%s</color></s>", desc)
		else
			name = luaLang("act183task_condition_title")
		end

		self._titleText.text = name
		self._descText.text = desc
	else
		self._titleText.text = ""
		self._descText.text = ""
	end
end

function Fight183TaskView:onClose()
	return
end

function Fight183TaskView:onDestroyView()
	return
end

return Fight183TaskView
