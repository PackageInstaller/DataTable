-- chunkname: @modules/logic/ressplit/work/ResSplitUIWork.lua

module("modules.logic.ressplit.work.ResSplitUIWork", package.seeall)

local ResSplitUIWork = class("ResSplitUIWork", BaseWork)

function ResSplitUIWork:onStart(context)
	local saveTypes = {
		"mainsceneswitch",
		"minors",
		"activity",
		"backpack",
		"battlepass",
		"character",
		"common",
		"commonbufftipview",
		"currency",
		"dungeon",
		"effect",
		"equip",
		"enemyinfo",
		"fight",
		"gift",
		"guide",
		"handbook",
		"help",
		"herogroup",
		"login",
		"mail",
		"main",
		"messagebox",
		"notice",
		"player",
		"power",
		"room",
		"rpcblock",
		"scene",
		"sdk",
		"settings",
		"signin",
		"skin",
		"social",
		"store",
		"story",
		"storynavigate",
		"summon",
		"summonresultview",
		"task",
		"teach",
		"tips",
		"toast",
		"video",
		"gm",
		"newwelfare",
		"share",
		"headicon_",
		"headskinicon_",
		"signature",
		"loading",
		"message",
		"nickname",
		"propitem",
		"textures",
		"data_pic",
		"mainsceneswitch"
	}
	local langDic = {
		"",
		"/lang/common",
		"/lang/en",
		"/lang/jp",
		"/lang/kr",
		"/lang/tw",
		"/lang/zh"
	}
	local excludeViewDicList = {}
	local excludeSinglebgDicList = {}
	local excludeSinglebgLangDicList = {}

	for _, lang in ipairs(langDic) do
		local basePath = "Assets/ZResourcesLib" .. lang .. "/ui/viewres/"

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. lang .. "/ui/viewres/") then
			local allUIViewres = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. lang .. "/ui/viewres/")

			for i = 0, allUIViewres.Length - 1 do
				local path = allUIViewres[i]

				if not string.find(path, ".meta") then
					local needSave = false

					for _, n in pairs(saveTypes) do
						if path == basePath .. n then
							needSave = true

							break
						end
					end

					if needSave == false then
						local p = string.gsub(path, "Assets/ZResourcesLib/", "") .. "/"

						table.insert(excludeViewDicList, p)
					end
				end
			end
		end

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. lang .. "/singlebg/") then
			local allUISinglebgDic = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. lang .. "/singlebg/")

			basePath = "Assets/ZResourcesLib" .. lang .. "/singlebg/"

			for i = 0, allUISinglebgDic.Length - 1 do
				local path = allUISinglebgDic[i]

				if not string.find(path, ".meta") then
					local needSave = false

					for _, n in pairs(saveTypes) do
						if string.find(path, basePath .. n) then
							needSave = true

							break
						end
					end

					if needSave == false then
						local p = string.gsub(path, "Assets/ZResourcesLib/", "") .. "/"

						table.insert(excludeSinglebgDicList, p)
					end
				end
			end
		end

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. lang .. "/singlebg_lang/") then
			local allUISinglebgLangDic = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. lang .. "/singlebg_lang/")

			basePath = "Assets/ZResourcesLib" .. lang .. "/singlebg_lang/"

			for i = 0, allUISinglebgLangDic.Length - 1 do
				local path = allUISinglebgLangDic[i]

				if not string.find(path, ".meta") then
					local needSave = false

					for _, n in pairs(saveTypes) do
						if string.find(path, n) or string.find(path, "txt_" .. n) then
							needSave = true

							break
						end
					end

					if needSave == false then
						local p = string.gsub(path, "Assets/ZResourcesLib/", "") .. "/"

						table.insert(excludeSinglebgLangDicList, p)
					end
				end
			end
		end
	end

	for i, v in pairs(excludeViewDicList) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, v, true)
	end

	for i, v in pairs(excludeSinglebgDicList) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, v, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, v, true)
	end

	for i, v in pairs(excludeSinglebgLangDicList) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, v, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, v, true)
	end

	self:onDone(true)
end

return ResSplitUIWork
