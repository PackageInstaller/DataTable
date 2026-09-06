-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/config/LoadingConfig.lua

module(..., package.seeall)

local LoadingConfig = class("LoadingConfig", BaseConfig)

function LoadingConfig:onInit()
	self._loadingTips = nil
	self._loadingPics = nil
end

function LoadingConfig:getNames()
	return {
		"loading_tips",
		"loading_pics"
	}
end

function LoadingConfig:handleConfig(name, content)
	if name == "loading_tips" then
		self._loadingTips = content
	elseif name == "loading_pics" then
		self._loadingPics = content
	end
end

function LoadingConfig:getLoadingTipsList()
	local tipsList = {}
	local dataList = self._loadingTips.dataList

	for i = 1, #dataList do
		local data = dataList[i]

		if data.funcId == 0 or data.funcId == nil or FuncOpenModel.instance:getFuncIsOpen(data.funcId) then
			table.insert(tipsList, data)
		end
	end

	if #tipsList == 0 then
		local data = dataList[1]

		data.des = "系统加载中，不消耗流量，请耐心等待"

		table.insert(tipsList, data)
	end

	return tipsList
end

function LoadingConfig:getLoadingPicsList()
	local picsList = {}
	local dataList = self._loadingPics.dataList

	for i = 1, #dataList do
		local data = dataList[i]

		if data.funcId == 0 or data.funcId == nil or FuncOpenModel.instance:getFuncIsOpen(data.funcId) then
			table.insert(picsList, data)
		end
	end

	if #picsList == 0 then
		table.insert(picsList, dataList[1])
	end

	return picsList
end

LoadingConfig.instance = LoadingConfig.New()

return LoadingConfig
