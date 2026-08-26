-- chunkname: @modules/logic/ressplit/work/save/ResSplitSaveUIWork.lua

module("modules.logic.ressplit.work.save.ResSplitSaveUIWork", package.seeall)

local ResSplitSaveUIWork = class("ResSplitSaveUIWork", BaseWork)

function ResSplitSaveUIWork:onStart(context)
	local saveTypes = {
		"common",
		"currency",
		"data_pic",
		"equipment",
		"rpcblock",
		"scene",
		"sdk",
		"store",
		"tips",
		"toast",
		"video",
		"gm",
		"loginbg",
		"share",
		"loading",
		"login",
		"propitem",
		"fight/skill",
		"equip_defaulticon",
		"optionalgift_singlebg"
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

					if needSave == true then
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

					if needSave == true then
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
						if string.find(path, n) then
							needSave = true

							break
						end
					end

					if needSave == true then
						local p = string.gsub(path, "Assets/ZResourcesLib/", "") .. "/"

						table.insert(excludeSinglebgLangDicList, p)
					end
				end
			end
		end
	end

	for i, v in pairs(excludeViewDicList) do
		ResSplitModel.instance:setInclude(ResSplitEnum.Folder, v, true)
	end

	for i, v in pairs(excludeSinglebgDicList) do
		ResSplitModel.instance:setInclude(ResSplitEnum.SinglebgFolder, v, true)
		ResSplitModel.instance:setInclude(ResSplitEnum.Folder, v, true)
	end

	for i, v in pairs(excludeSinglebgLangDicList) do
		ResSplitModel.instance:setInclude(ResSplitEnum.SinglebgFolder, v, true)
		ResSplitModel.instance:setInclude(ResSplitEnum.Folder, v, true)
	end

	for _, v in pairs(saveTypes) do
		ResSplitModel.instance:setInclude(ResSplitEnum.Folder, "ui/texture/" .. v .. "/", true)
	end

	ResSplitModel.instance:setInclude(ResSplitEnum.SinglebgFolder, "singlebg/fight/skill/", true)
	ResSplitModel.instance:setInclude(ResSplitEnum.Folder, "singlebg/fight/skill/", true)
	self:onDone(true)
end

return ResSplitSaveUIWork
