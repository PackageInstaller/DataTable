-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/theater/model/TheaterModel.lua

module("logic.extensions.theater.model.TheaterModel", package.seeall)

local TheaterModel = class("TheaterModel", BaseModel)

function TheaterModel:ctor()
	TheaterModel.super.ctor(self)
end

function TheaterModel:onInit()
	TheaterModel.super.onInit(self)
end

function TheaterModel:onReset()
	TheaterModel.super.onReset(self)
end

function TheaterModel:getInitRuleById(id)
	local ruleInfo = {}
	local ruleCfg = TheaterConfig.instance:getRuleById(id)

	for i, str in ipairs(ruleCfg.ruleList) do
		local sp = string.split(str, "#")

		ruleInfo[sp[1]] = {}

		for j, s in ipairs(string.split(sp[2], ",")) do
			local param = string.split(s, ":")

			if param[1] == "defaultAction" then
				ruleInfo[sp[1]].defaultAction = TheaterConfig.instance:getActionById(tonumber(param[2]))
			elseif param[1] == "defaultFace" then
				ruleInfo[sp[1]].defaultFace = TheaterConfig.instance:getFaceById(tonumber(param[2]))
			elseif param[1] == "defaultExpression" then
				ruleInfo[sp[1]].defaultExpression = TheaterConfig.instance:getExpressionById(tonumber(param[2]))
			end
		end
	end

	return ruleInfo
end

function TheaterModel:getInitContentById(id)
	local contentInfo = {}
	local contentCfg = TheaterConfig.instance:getContentById(id)

	for i, statusCfg in ipairs(contentCfg) do
		local statusInfo = {}
		local actionList, faceList, expressionList, dialogList, pointList = {}, {}, {}, {}, {}

		for k, ruleCfg in pairs(statusCfg) do
			if type(ruleCfg) == "table" then
				if ruleCfg.action then
					for i, action in ipairs(ruleCfg.action) do
						local param = string.split(action, "#")
						local cfg = TheaterConfig.instance:getActionById(checknumber(param[1]))

						if cfg then
							table.insert(actionList, {
								ruleName = k,
								name = cfg.name,
								startTime = checknumber(param[2])
							})
						end
					end
				end

				if ruleCfg.face then
					for i, face in ipairs(ruleCfg.face) do
						local param, faceTab = string.split(face, "#"), {}
						local cfg = TheaterConfig.instance:getFaceById(checknumber(param[1]))

						if cfg then
							faceTab = {
								ruleName = k,
								url = GameUrl.getTheaterUrl(cfg.url),
								startTime = checknumber(param[2])
							}

							if param[3] then
								local sp = string.split(param[3], "_")

								faceTab.x = tonumber(sp[1])
								faceTab.y = tonumber(sp[2])
								faceTab.z = tonumber(sp[3])
							end

							table.insert(faceList, faceTab)
						end
					end
				end

				if ruleCfg.expression then
					for i, expression in ipairs(ruleCfg.expression) do
						local param = string.split(expression, "#")
						local cfg = TheaterConfig.instance:getExpressionById(checknumber(param[1]))

						if cfg then
							local var_5_1 = {
								ruleName = k,
								url = GameUrl.getTheaterUrl(cfg.url),
								startTime = checknumber(param[2])
							}

							var_5_1.endTime = tonumber(param[3]) or -1

							table.insert(expressionList, var_5_1)
						end
					end
				end

				if ruleCfg.dialog then
					for i, dialog in ipairs(ruleCfg.dialog) do
						local param = string.split(dialog, "#")
						local cfg = TheaterConfig.instance:getDialogById(checknumber(param[1]))

						if cfg then
							local var_5_3 = {
								ruleName = k,
								content = cfg.content,
								startTime = checknumber(param[2])
							}

							var_5_3.endTime = tonumber(param[3]) or -1

							table.insert(dialogList, var_5_3)
						end
					end
				end

				if ruleCfg.pathPoint then
					local start, fixedTime, lastTime, points = Vector2.New(), UnityEngine.Time.fixedDeltaTime, 0, {}

					for i, point in ipairs(ruleCfg.pathPoint) do
						local param = string.split(point, "#")
						local length = (tonumber(param[1]) - lastTime) / fixedTime
						local destination = Vector2.New(tonumber(param[2]), tonumber(param[3]))
						local t = i / length

						for i = 0, length do
							table.insert(points, Vector2.Lerp(start, destination, t * i))
						end

						start = destination
						lastTime = param[i]
					end

					table.insert(pointList, {
						ruleName = k,
						points = points
					})
				end
			end
		end

		local function sortList(a, b)
			return a.startTime < b.startTime
		end

		if #actionList > 0 then
			table.sort(actionList, sortList)

			statusInfo.actionList = actionList
		end

		if #faceList > 0 then
			table.sort(faceList, sortList)

			statusInfo.faceList = faceList
		end

		if #expressionList > 0 then
			table.sort(expressionList, sortList)

			statusInfo.expressionList = expressionList
		end

		if #dialogList > 0 then
			table.sort(dialogList, sortList)

			statusInfo.dialogList = dialogList
		end

		if #pointList > 0 then
			statusInfo.pointList = pointList
		end

		contentInfo[i] = statusInfo
	end

	return contentInfo
end

function TheaterModel:getRuleComponents(go)
	local model = {
		go = go,
		rule = goutil.findChild(go, "rule"),
		animation = go:GetComponent("Animation"),
		dialogGo = goutil.findChild(go, "rule/dialog"),
		dialogText = goutil.findChildComponent(go, "rule/dialog/Text", "TypewriterNew"),
		expression = goutil.findChild(go, "rule/expression"),
		face = goutil.findChild(go, "rule/face")
	}

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(model.dialogText.gameObject:GetComponent(goutil.Type_RectTransform))

	model.dialogHeightDiff = GameUtil.getHeight(model.dialogGo) - GameUtil.getHeight(model.dialogText.gameObject)
	model.dialogWidthDiff = GameUtil.getWidth(model.dialogGo) - GameUtil.getWidth(model.dialogText.gameObject)

	return model
end

TheaterModel.instance = TheaterModel.New()

return TheaterModel
