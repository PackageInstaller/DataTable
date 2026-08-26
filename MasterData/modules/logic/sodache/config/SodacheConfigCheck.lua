-- chunkname: @modules/logic/sodache/config/SodacheConfigCheck.lua

module("modules.logic.sodache.config.SodacheConfigCheck", package.seeall)

local SodacheConfigCheck = class("SodacheConfigCheck")

function SodacheConfigCheck:process_sodache_event(configTable)
	for i, v in ipairs(configTable.configList) do
		if GameResMgr.IsFromEditorDir then
			local path = v.path

			if not string.nilorempty(path) and not io.open("Assets/ZResourcesLib/" .. path, "r") then
				logError("资源不存在！！" .. v.id .. " >> " .. path)
			end
		end

		if v.type == "altar" and v.retain ~= 1 then
			logError("祭坛没有配置完成保留！！" .. v.id)
		end

		if v.type ~= "container" and not string.nilorempty(v.dropPreview) then
			logWarn("不是容器事件也配了掉落预览！！" .. v.id)
		end
	end
end

function SodacheConfigCheck:process_sodache_choice(configTable)
	local lang = _G.lang

	rawset(_G, "lang", function(val)
		return val
	end)

	local containerEventCount = {}

	GameUtil.setDefaultValue(containerEventCount, 0)

	local eventIdToDialog = {}

	for i, v in ipairs(configTable.configList) do
		local eventCo = lua_sodache_event.configDict[v.eventId]

		if not eventCo then
			logError("选项对应的事件ID不存在！！" .. v.id)
		elseif eventCo.type == "container" then
			if v.initialSelect == 1 then
				containerEventCount[v.eventId] = containerEventCount[v.eventId] + 1
			else
				logError("容器事件的选项并非初始选项！！！" .. v.id)
			end

			if not string.nilorempty(v.selectCond) then
				logError("容器事件的选项不能配选项条件！！！" .. v.id)
			end
		elseif (eventCo.type == "random" or eventCo.type == "dialogue") and string.nilorempty(v.desc) then
			logWarn("选项ID没有配置描述！！！" .. v.id)
		end

		if v.initialSelect == 1 and v.dialogDefault > 0 then
			eventIdToDialog[v.eventId] = eventIdToDialog[v.eventId] or {}

			table.insert(eventIdToDialog[v.eventId], v.dialogDefault)
		end
	end

	for i, v in ipairs(lua_sodache_event.configList) do
		if v.type == "container" and containerEventCount[v.id] ~= 1 then
			logError("容器事件的选项数量错误：" .. v.id .. " >>> " .. containerEventCount[v.id])
		end
	end

	rawset(_G, "lang", lang)

	for k, v in pairs(eventIdToDialog) do
		if #v > 1 then
			logError("选项初始对话配置>1：" .. k .. " >> " .. table.concat(v, ","))
		end
	end
end

function SodacheConfigCheck:process_sodache_dialog(configTable)
	for i, v in ipairs(configTable.configList) do
		if v.position ~= 1 and v.position ~= 2 then
			logError("事件对话的类型配置错误！！" .. v.id)
		end
	end
end

function SodacheConfigCheck:process_sodache_task(configTable)
	for i, v in ipairs(configTable.configList) do
		local drops = GameUtil.splitString2(v.rewardShow, true, ";", "&") or {}

		for _, vv in ipairs(drops) do
			local cardMo = SodacheCardMo.Create(vv[1])

			if not cardMo.serverMo.itemCo then
				logError("任务表配了不存在的任务奖励：" .. v.id)
			end
		end
	end
end

function SodacheConfigCheck:process_sodache_handbook(configTable)
	for i, v in ipairs(configTable.configList) do
		if v.tab1 == SodacheEnum.HandBookType.Card then
			local co = lua_sodache_card.configDict[v.eleId]

			if not co then
				logError("图鉴表配置了不存在的卡牌" .. v.id .. " >> " .. v.eleId)
			end
		end
	end
end

SodacheConfigCheck.instance = SodacheConfigCheck.New()

return SodacheConfigCheck
