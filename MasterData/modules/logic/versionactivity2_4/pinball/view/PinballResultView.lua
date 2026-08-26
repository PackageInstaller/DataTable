-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballResultView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballResultView", package.seeall)

local PinballResultView = class("PinballResultView", BaseView)

function PinballResultView:onInitView()
	self._goFinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._gonoFinish = gohelper.findChild(self.viewGO, "#go_noFinish")
	self._txttask = gohelper.findChildTextMesh(self.viewGO, "#go_finish/#txt_taskdes")
	self._txttask2 = gohelper.findChildTextMesh(self.viewGO, "#go_noFinish/#txt_taskdes")
	self._resexitem = gohelper.findChild(self.viewGO, "#go_finish/items_ex/item")
	self._resitem = gohelper.findChild(self.viewGO, "items/item")
end

function PinballResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio20)

	local episodeCo = lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballModel.instance.leftEpisodeId]

	if not episodeCo then
		return
	end

	self:updateTask(episodeCo)

	local totalRes = PinballModel.instance.gameAddResDict
	local currencyTypes = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}
	local data1 = {}
	local data2 = {}

	for index, resType in ipairs(currencyTypes) do
		local talentAdd = PinballModel.instance:getResAdd(resType)
		local var_2_0 = {
			resType = resType
		}

		var_2_0.value = (totalRes[resType] or 0) * (1 + talentAdd)
		data1[index] = var_2_0

		if self._isFinish and self._taskRewardDict[resType] then
			table.insert(data2, {
				resType = resType,
				value = self._taskRewardDict[resType]
			})
		end
	end

	gohelper.CreateObjList(self, self.createItem, data1, nil, self._resitem)

	if self._isFinish then
		gohelper.CreateObjList(self, self.createItem, data2, nil, self._resexitem)
	end
end

function PinballResultView:updateTask(episodeCo)
	local arr = string.splitToNumber(episodeCo.target, "#")

	if not arr or #arr ~= 2 then
		logError("任务配置错误" .. episodeCo.id)

		return
	end

	local type = arr[1]
	local curVal = PinballModel.instance:getGameRes(type)
	local totalVal = arr[2]

	self._isFinish = totalVal <= curVal

	gohelper.setActive(self._goFinish, self._isFinish)
	gohelper.setActive(self._gonoFinish, not self._isFinish)

	local resName = ""

	if type == 0 then
		resName = luaLang("pinball_any_res")
	else
		local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][type]

		if resCo then
			resName = resCo.name
		end
	end

	self._txttask.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_game_target2"), totalVal, resName)
	self._txttask2.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_game_target2"), totalVal, resName)

	if not self._isFinish then
		return
	end

	local taskReward = GameUtil.splitString2(episodeCo.reward, true) or {}

	self._taskRewardDict = {}

	for _, reward in pairs(taskReward) do
		self._taskRewardDict[reward[1]] = reward[2]
	end
end

function PinballResultView:createItem(obj, data, index)
	local icon = gohelper.findChildImage(obj, "#image_icon")
	local num = gohelper.findChildTextMesh(obj, "#txt_num")

	num.text = Mathf.Round(data.value)

	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][data.resType]

	if not resCo then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(icon, resCo.icon)
end

function PinballResultView:onClickModalMask()
	ViewMgr.instance:closeView(ViewName.PinballGameView)
	self:closeThis()
end

return PinballResultView
