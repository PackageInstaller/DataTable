-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mopup/view/MopupItem.lua

module("logic.extensions.mopup.view.MopupItem", package.seeall)

local MopupItem = class("MopupItem")

function MopupItem.AddOnce(go)
	return GameUtil.AddLuaOnce(go, MopupItem)
end

function MopupItem.Remove(go)
	local obj = GameUtil.GetLua(go, MopupItem)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, MopupItem)
end

function MopupItem:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
	self:initEvent()
end

function MopupItem:dispose()
	self:unbindEvent()
	self:onExit()
end

function MopupItem:unbindEvent()
	return
end

function MopupItem:initEvent()
	return
end

function MopupItem:buildUI()
	self.txtTitle = goutil.findChildTextComponent(self.mainGO, "txtSweepCount")
	self.itemCon = goutil.findChild(self.mainGO, "itemCon")
	self.cloneGo = goutil.findChild(self.mainGO, "itemCon/cell")
	self.itemGroup = ItemGroup.New(self.itemCon, self.cloneGo, nil, nil, true)
end

function MopupItem:OnDestroy()
	self:dispose()
end

function MopupItem:onExit()
	self.itemGroup:dispose(function(item)
		local con = goutil.findChild(item.mainGO, "con")

		MaterialMgr.resetAll(con)
	end)
end

function MopupItem:setData(data, index)
	GameUtil.setLocalPos(self.mainGO, 100 * index, 0, 0)

	self.txtTitle.text = data.isInit and "可能获得的奖励" or "第" .. index .. "次扫荡"

	self.itemGroup:updateWithMoArray(data.list, function(item, rewardData)
		item.con = item.con or goutil.findChild(item.mainGO, "con")
		item.double = item.double or goutil.findChild(item.mainGO, "double")

		local matStr = rewardData
		local holyStripeMo

		if type(rewardData) == "table" then
			matStr = rewardData.cfgStr
			holyStripeMo = rewardData.holyStripeMo
		end

		if data.rewardMultiply and string.find(matStr, "8:6") ~= 1 then
			GameUtil.SetActive(item.double, true)

			item.txt = item.txt or goutil.findChildTextComponent(item.mainGO, "double/Text")

			local doubleNum = 100

			if checknumber(data.multiple) > 0 then
				doubleNum = doubleNum * data.multiple
			end

			item.txt.text = string.format("+%s%%", doubleNum)
		else
			GameUtil.SetActive(item.double, false)
		end

		if holyStripeMo then
			MaterialMgr.setCellByMo(holyStripeMo, item.con)
		else
			MaterialMgr.setCellByCfg(matStr, item.con)
		end

		local realXIdx = (item.index - 1) % 4
		local line = math.ceil(item.index / 4)

		GameUtil.setLocalPos(item.mainGO, 140 * realXIdx + 25, -25 - (line - 1) * 112, 0)
	end)
end

return MopupItem
