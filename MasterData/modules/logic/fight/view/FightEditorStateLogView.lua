-- chunkname: @modules/logic/fight/view/FightEditorStateLogView.lua

module("modules.logic.fight.view.FightEditorStateLogView", package.seeall)

local FightEditorStateLogView = class("FightEditorStateLogView", BaseViewExtended)

function FightEditorStateLogView:onInitView()
	self._btnListRoot = gohelper.findChild(self.viewGO, "btnScrill/Viewport/Content")
	self._btnModel = gohelper.findChild(self._btnListRoot, "btnModel")
	self._logText = gohelper.findChildText(self.viewGO, "ScrollView/Viewport/Content/logText")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightEditorStateLogView:addEvents()
	return
end

function FightEditorStateLogView:removeEvents()
	return
end

function FightEditorStateLogView:_editableInitView()
	return
end

function FightEditorStateLogView:onRefreshViewParam()
	return
end

function FightEditorStateLogView.processStr(content)
	local findPattern = "cardInfoList.-heroId: [-%d]+"
	local startIndex, endIndex = string.find(content, findPattern)
	local tempStr1 = ""
	local tempStr2 = ""

	while startIndex do
		tempStr1 = string.sub(content, 1, startIndex - 1)
		tempStr2 = string.sub(content, startIndex, -1)
		tempStr2 = string.gsub(tempStr2, "(uid: ([-%d]+))", function(str1, str2)
			local fillContent = ""
			local fromEntityMO = FightLocalDataMgr.instance:getEntityById(str2)

			fillContent = fillContent .. str1 .. " 卡牌持有者:" .. ((fromEntityMO or nil) and fromEntityMO:getEntityName())

			return fillContent
		end, 1)
		tempStr2 = string.gsub(tempStr2, "(skillId: ([-%d]+))", function(str1, str2)
			local fillContent = ""
			local skillId = tonumber(str2)
			local config = lua_skill.configDict[skillId]

			fillContent = fillContent .. str1 .. " 技能名称:" .. ((config or nil) and (config.name or ""))

			return fillContent .. str1 .. " 技能名称:" .. ((config or nil) and (config.name or ""))
		end, 1)
		tempStr2 = string.gsub(tempStr2, "(heroId: ([-%d]+))", function(str1, str2)
			local fillContent = ""

			fillContent = fillContent .. str1 .. " 模型id(肉鸽支援技能牌会用到):" .. str2

			return fillContent
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	findPattern = "modelId: %d+"
	startIndex, endIndex = string.find(content, "modelId: %d+")

	while startIndex do
		tempStr1 = string.sub(content, 1, startIndex - 1)
		tempStr2 = string.sub(content, startIndex, -1)
		tempStr2 = string.gsub(tempStr2, "(modelId: (%d+))", function(str1, str2)
			local modelId = tonumber(str2)

			if not lua_character.configDict[modelId] then
				if lua_character.configDict[modelId] then
					if not lua_character.configDict[modelId].name then
						local name = ""

						return str1 .. " 角色名称:" .. name
					end
				end
			end
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	findPattern = "skin: [-%d]+"
	startIndex, endIndex = string.find(content, "skin: [-%d]+")

	while startIndex do
		tempStr1 = string.sub(content, 1, startIndex - 1)
		tempStr2 = string.sub(content, startIndex, -1)
		tempStr2 = string.gsub(tempStr2, "(skin: ([-%d]+))", function(str1, str2)
			return str1 .. " 皮肤id:" .. str2
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	findPattern = "actType: [-%d]+"
	startIndex, endIndex = string.find(content, "actType: [-%d]+")

	while startIndex do
		tempStr1 = string.sub(content, 1, startIndex - 1)
		tempStr2 = string.sub(content, startIndex, -1)
		tempStr2 = string.gsub(tempStr2, "(actType: ([-%d]+))", function(str1, str2)
			if str2 == "1" then
				return str1 .. " 步骤类型:技能"
			elseif str2 == "2" then
				return str1 .. " 步骤类型:buff"
			elseif str2 == "3" then
				return str1 .. " 步骤类型:效果"
			elseif str2 == "4" then
				return str1 .. " 步骤类型:换人"
			elseif str2 == "5" then
				return str1 .. " 步骤类型:换波次时机（供客户端使用）"
			end

			return str1
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	findPattern = "步骤类型:技能"
	startIndex, endIndex = string.find(content, "步骤类型:技能")

	while startIndex do
		tempStr1 = string.sub(content, 1, startIndex - 1)
		tempStr2 = string.sub(content, startIndex, -1)

		local fromEntityId

		tempStr2 = string.gsub(tempStr2, "(fromId: ([-%d]+))", function(str1, str2)
			local entityId = str2
			local name = ""

			if str2 == FightEntityScene.MySideId then
				name = "维尔汀"
			elseif str2 == FightEntityScene.EnemySideId then
				name = "重塑之手"
			else
				fromEntityId = entityId

				local fromEntityMO = FightLocalDataMgr.instance:getEntityById(entityId)

				if fromEntityMO then
					name = fromEntityMO:getEntityName()
				end
			end

			return str1 .. " 技能发起者:" .. name
		end, 1)
		tempStr2 = string.gsub(tempStr2, "(toId: ([-%d]+))", function(str1, str2)
			local entityId = str2
			local name = ""

			if str2 == FightEntityScene.MySideId then
				name = "维尔汀"
			elseif str2 == FightEntityScene.EnemySideId then
				name = "重塑之手"
			else
				local fromEntityMO = FightLocalDataMgr.instance:getEntityById(entityId)

				if fromEntityMO then
					name = fromEntityMO:getEntityName()
				end
			end

			return str1 .. " 技能承受者:" .. name
		end, 1)
		tempStr2 = string.gsub(tempStr2, "(actId: ([-%d]+))", function(str1, str2)
			local skillId = tonumber(str2)
			local config = lua_skill.configDict[skillId]

			if config then
				if not config.name then
					local name = ""

					return str1 .. " 技能id:" .. str2 .. " 技能名字:" .. name .. " timeline : " .. FightLogHelper.getTimelineName(fromEntityId, skillId)
				end
			end
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	findPattern = "targetId: [-%d]+"
	startIndex, endIndex = string.find(content, "targetId: [-%d]+")

	while startIndex do
		tempStr1 = string.sub(content, 1, startIndex - 1)
		tempStr2 = string.sub(content, startIndex, -1)
		tempStr2 = string.gsub(tempStr2, "(targetId: ([-%d]+))", function(str1, str2)
			local entityId = str2
			local name = ""

			if str2 == FightEntityScene.MySideId then
				name = "维尔汀"
			elseif str2 == FightEntityScene.EnemySideId then
				name = "重塑之手"
			else
				local fromEntityMO = FightLocalDataMgr.instance:getEntityById(entityId)

				if fromEntityMO then
					name = fromEntityMO:getEntityName()
				end
			end

			return str1 .. " 作用对象:" .. name
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	findPattern = "buffId: %d+"
	startIndex, endIndex = string.find(content, "buffId: %d+")

	while startIndex do
		tempStr1 = string.sub(content, 1, startIndex - 1)
		tempStr2 = string.sub(content, startIndex, -1)
		tempStr2 = string.gsub(tempStr2, "(buffId: ([-%d]+))", function(str1, str2)
			local buffId = tonumber(str2)
			local buffConfig = lua_skill_buff.configDict[buffId]

			if buffConfig then
				if not buffConfig.name then
					local name = ""

					return str1 .. " buff名称:" .. name
				end
			end
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	content = FightEditorStateLogView.typeExplain(content)

	return content
end

function FightEditorStateLogView:onOpen()
	self._type2FuncName = {}

	local roundProtoList = FightDataHelper.protoCacheMgr.roundProtoList

	self._strList = {}

	self:addLog("入场数据")
	self:addLog(FightHelper.logStr(FightDataHelper.roundMgr.enterData))

	for i, proto in ipairs(roundProtoList) do
		local preRoundProto = roundProtoList[i - 1]

		if preRoundProto then
			self:addLog("回合" .. preRoundProto.curRound)
		end

		self:addLog(tostring(proto))
	end

	local str = ""

	for i, v in ipairs(self._strList) do
		str = str .. v .. "\n"
	end

	self._logText.text = FightEditorStateLogView.processStr(str)

	local btnData = {
		{
			name = "复制"
		}
	}

	self:com_createObjList(self._onBtnItemShow, btnData, self._btnListRoot, self._btnModel)
end

function FightEditorStateLogView:_onBtnItemShow(obj, data, index)
	local text = gohelper.findChildText(obj, "text")

	text.text = data.name

	local btn = gohelper.findChildClick(obj, "btn")

	self.addClickCb(self, btn, self["_onBtnClick" .. index], self)
end

function FightEditorStateLogView:_onBtnClick1()
	ZProj.UGUIHelper.CopyText(self._logText.text)
end

function FightEditorStateLogView:addLog(str)
	table.insert(self._strList, str)
end

function FightEditorStateLogView:onClose()
	return
end

function FightEditorStateLogView:onDestroyView()
	return
end

function FightEditorStateLogView.typeExplain(content)
	local path = "Assets/ZProj/Scripts/Lua/modules/logic/fight/config/FightEnum.lua"
	local file = io.open(path, "r")
	local str = file:read("*a")

	file:close()

	local startIndex, endIndex = string.find(str, "FightEnum.EffectType = {.-}")

	str = string.sub(str, startIndex, endIndex)
	str = string.gsub(str, "FightEnum.EffectType =", "")

	local tab = {}

	for k, v in string.gmatch(str, "=.-([-%d]+).-%-%-(.-)\n") do
		tab[k] = v
	end

	local findPattern = "effectType: [-%d]+"

	startIndex, endIndex = string.find(content, findPattern)

	while startIndex do
		local tempStr1 = string.sub(content, 1, startIndex - 1)
		local tempStr2 = string.sub(content, startIndex, -1)

		tempStr2 = string.gsub(tempStr2, "(effectType: ([-%d]+))", function(str1, str2)
			return str1 .. " " .. (tab[str2] or "")
		end, 1)
		content = tempStr1 .. tempStr2
		startIndex, endIndex = string.find(tempStr1 .. tempStr2, findPattern, startIndex + 1)
	end

	return content
end

return FightEditorStateLogView
