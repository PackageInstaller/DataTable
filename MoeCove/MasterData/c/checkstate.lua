--这个state是用来进行热更处理的lua处理代码，但是，这个是原本在lua自身实现的热更中使用，现在的框架中，已经将这部分功能调整到了C#中，所以，这部分代码就没有用了

require "FSM"
require "GameFlowState"

local bit = require("bit")
local json = require "cjson"

local VersionCodeKey = "VersionCode"
local localBuildCodeKey = "BuildCode"

-- local function GetVersionCode(verCode)
--     local code4 = bit.band(verCode, 0xff)
--     local code3 = bit.band(bit.rshift(verCode, 8),  0xff)
--     local code2 = bit.band(bit.rshift(verCode, 16), 0xff)
--     local code1 = bit.band(bit.rshift(verCode, 24), 0xff)
--     return code1, code2, code3, code4
-- end

-- local function MakeVersionCode(code1, code2, code3, code4)
--     code1 = bit.lshift(code1, 24)
--     code2 = bit.lshift(code2, 16)
--     code3 = bit.lshift(code3, 8)
--     code4 = bit.lshift(code4, 0)

--     return bit.bor(code1, code2, code3, code4)
-- end

-- 这是用来进行热更处理的lua处理代码
-- ********已经废弃********

local UpdateState = 
{
	WaitForVersion = 1,
	WaitForUpdate = 2,
	NewUpdate = 3,
	Updating = 4,
	StartCopy = 5,
	Copying = 6,
	UpdateFinished = 7,
	UpdateFailed = 8,
}


local function getPlatformName()
	if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor then
		return "Windows"
	elseif Application.platform == UnityEngine.RuntimePlatform.Android then
		return "Android"
	elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
		return "iOS"
	end
	return "unkown"
end

local CurrentVersionCode = UpdateManager.Version
local s_beginUpdate = false

local updateMgr = UpdateManager.Instance
local updateResUrl = "http://localhost:8080/"
local platformName = getPlatformName()
local updateFileUrl = updateResUrl .. string.format("FileList_%s.txt", platformName)

local originFileList = updateMgr.UpdateFilePath
local downloadUpdateDir = updateMgr.RootPath .. "Update/"
local downloadUpdateScriptDir = downloadUpdateDir .. "Script/"
local downloadUpdateBundleDir = downloadUpdateDir .. "Bundles/"
local downloadUpdateFile = downloadUpdateDir .. "UpdateFile.txt"

local function GetFixedPath( fileName )
	if string.find(fileName, ".lua") or string.find(fileName, ".pb") then
		--script
		fileName = updateMgr.LuaPath .. fileName
	else
		--bundle
		fileName = updateMgr.BundlePath .. fileName
	end
	return fileName
end

local function IsScriptFile( fileName )
	if string.find(fileName, ".lua") or string.find(fileName, ".pb") then
		return true
	else
		return false
	end
end

local function GetShouldUpdateFileList(originPath, updatePath)
	local originText
	if DFileUtil.FileExists(originPath) == true then
		originText = DFileUtil.ReadAllText(originPath)
	end
	local updateText = DFileUtil.ReadAllText(updatePath)

	if not updateText then
		LuaLogger.e("updatePath {0} is empty", updatePath)
		return
	end

    local shouldUpdate = {}
    local shouldDelete = {}
    local cacheDic = {}
    local originFileList
    if originText then
    	originFileList = json.decode(originText)
    	for i,v in ipairs(originFileList.UpdateList) do
    		local fileName = GetFixedPath(v.name)
    		if DFileUtil.FileExists(fileName) == true then
				cacheDic[v.name] = v
			end
	    end
    end
    
    local updateFileList = json.decode(updateText)
    local updateCacheDic = {}
    for i,v in ipairs(updateFileList.UpdateList) do
    	updateCacheDic[v.name] = v
    	local updateInfo = cacheDic[v.name]
    	if updateInfo then
    		if updateInfo.size ~= v.size or updateInfo.hash ~= v.hash then
    			table.insert(shouldUpdate, v)
    		end
    	else
			table.insert(shouldUpdate, v)
    	end
    end

    for i,v in pairs(cacheDic) do
    	local updateInfo = updateCacheDic[v.name]
    	if updateInfo then
    	else
			table.insert(shouldDelete, v)
    	end
    end
    

    --删除
    --错误异常处理

    return shouldUpdate, shouldDelete
end

---@class CheckState : FSMState
local CheckState = FSMState:new("CheckState", GameFlowState.CheckState)

-- 利用GameFlowState的功能来实现整个热更逻辑
function CheckState:enter()
	self.updateState = UpdateState.WaitForVersion
	self.updateList = nil
	self.updateListCount = 0
	
	--只有在BundleMode下，才会进入到更新的流程
	if EngineGlobal.BundleMode then
		UIMgr:popUI("CheckUpdateWnd", nil, function(ui)
		-- GetVersionCode from server
			self.ui = ui
			self:CheckFiles()
			self:GetVersion()
		end)
	else
		if GV.GlobalConfig.IsSkipHealthText() then
			StateMgr:ChangeToState(GameFlowState.LoginState)
		else
			StateMgr:ChangeToState(GameFlowState.AuditingState)
		end
	end
	
end

function CheckState:Quit()
	Application.Quit()
end

function CheckState:Failed()
	updateMgr.ErrorCount = updateMgr.ErrorCount + 1
	if updateMgr.ErrorCount > 5 then
		UIMgr:popUI("CheckUpdateMsgBox", { updateError = true, callBack = function()
			self:Quit()
		end})
	else
		Restart()
	end
end

-- 获取本地的文件列表
function CheckState:CheckFiles()
	self.checkFileOK = true
	if DFileUtil.FileExists(originFileList) == true then
		local originText = DFileUtil.ReadAllText(originFileList)
		local originFileList = json.decode(originText)
    	for i,v in ipairs(originFileList.UpdateList) do
    		local fileName = GetFixedPath(v.name)
			if DFileUtil.FileExists(fileName) == false then
				self.checkFileOK = false
				break
			end
	    end
	else
		self.checkFileOK = false
	end

	-- if FirstScriptDowned() == false then
	-- 	self.checkFileOK = false
	-- end
end

--暂时模拟获取版本号 到时候会改成异步获得
function CheckState:GetVersion()

	-- 从本地信息中获取当前的版本号
	local versionCode = PlayerPrefs.GetInt(VersionCodeKey, 0)
	if versionCode == 0 then
		versionCode = CurrentVersionCode
		PlayerPrefs.SetInt(VersionCodeKey, versionCode)
		PlayerPrefs.Save()
		self.checkFileOK = false
	end

	-- 进行版本号对比
	local function checkVersion()
		-- 如果版本号一致，则直接进入LoginState
		if versionCode == self.serverCode and self.checkFileOK then
			StateMgr:ChangeToState(GameFlowState.LoginState)
			return
		end

		local code1, code2, code3, code4 	 = UpdateManager.ParseVerCode(versionCode, nil, nil, nil, nil)
		local sCode1, sCode2, sCode3, sCode4 = UpdateManager.ParseVerCode(self.serverCode, nil, nil, nil, nil)
		
		-- 如果第一个版本号和第二个版本号不一致，则需要进入版本下载链接进行更新游戏ipa或者apk
		-- 按照文档来说，不应该是前三个版本号？
		if sCode1 ~= code1 or sCode2 ~= code2 then
			--LuaLogger.e("Update Package")
			self.ui:UpdatePackage(function()
				--安装包链接
				--Application.OpenURL("http://www.moefantasy.com/")
				self:Quit()
			end)
			return
		end
		
		-- 如果第三位版本号提升了，则必须进行更新操作
		local OptinalUpdate = false
		if sCode3 > code3 or self.checkFileOK == false then
			--LuaLogger.e("Must update bundle")
			self.ui:MustUpdate()
			--return
		elseif sCode4 > code4 then -- 如果第三位相同，第四位提升，则进入选择性更新的状态
			--LuaLogger.e("Optinal update")
			self.ui:OptinalUpdate()
			OptinalUpdate = true
			--return
		end

		DFileUtil.DeleteDir(downloadUpdateDir)
		DFileUtil.CreateDir(downloadUpdateDir)
		DFileUtil.DeleteDir(downloadUpdateScriptDir)
		DFileUtil.CreateDir(downloadUpdateScriptDir)
		DFileUtil.DeleteDir(downloadUpdateBundleDir)
		DFileUtil.CreateDir(downloadUpdateBundleDir)

		DFileUtil.DownloadFile(updateFileUrl,  downloadUpdateFile, function (len, total)
			end, function (error)
				if not error then
					-- 获取了两个list后，对比差异，形成更新列表
					self.updateList, self.deleteList = GetShouldUpdateFileList(originFileList, downloadUpdateFile)
					self.updateListCount = #self.updateList
					self.updateState = UpdateState.WaitForUpdate
					-- 调用CheckUpdateWnd的更新文件，让玩家确认后，进入热更状态
					self.ui:SetUpdateFiles(self.updateList, self.deleteList, function(bUpdate)
						if bUpdate == true then
							self.updateState = UpdateState.NewUpdate -- 进入更新状态
						else
							-- optionUpdate可以直接进入登录状态
							if OptinalUpdate == true then
								StateMgr:ChangeToState(GameFlowState.LoginState)
							else
								self:Quit()
							end
						end
					end)
					
				else
					-- 获取更新信息失败
					self.updateState = UpdateState.UpdateFailed
					LuaLogger.e("DownLoad UpdateFile Failed")
					self:Failed()
				end
			end)
	end
	-- 这个是啥意思？
	self.serverCode = UpdateManager.MakeVerCode(0, 0, 0, 0)

	checkVersion()
end

function CheckState:update()
    --print(string.format("CheckState %s update", self.name))

    if self.updateState ~= UpdateState.NewUpdate and self.updateState ~= UpdateState.StartCopy then
    	return
    end

	if self.updateState == UpdateState.NewUpdate then
		-- 如果更新列表为0，也就是完成了所有的文件下载，直接进入下一步
		if #self.updateList == 0  then
			self.updateState = UpdateState.StartCopy
		else
			local downFileData = self.updateList[#self.updateList]
			local downFileName = downFileData.name
			local downloadFileUrl = updateResUrl
			local downloadDstPath
			if string.find(downFileName, ".lua") or string.find(downFileName, ".pb") then
				--script
				downloadFileUrl = downloadFileUrl .. "Script/" .. downFileName
				downloadDstPath = downloadUpdateScriptDir .. downFileName
			else
				--bundle
				downloadFileUrl = downloadFileUrl .. "Bundles/" .. platformName .. "/" .. downFileName
				downloadDstPath = downloadUpdateBundleDir .. downFileName
			end
			
			-- 进入下载文件的状态
			self.ui:StartDownLoad(self.updateListCount - #self.updateList)
			self.updateList[#self.updateList] = nil
			self.updateState = UpdateState.Updating
			DFileUtil.DownloadFile(downloadFileUrl, downloadDstPath, function (len, total)
					self.ui:DownLoading(len, total)
				end, function (error)
					if not error then
						if #self.updateList >= 0 then
							self.updateState = UpdateState.NewUpdate
						end
					else
						self.updateState = UpdateState.UpdateFailed
						LuaLogger.es("Update download file %s failed", downloadFileUrl)
						self:Failed()
						-- todo
					end
				end)
		end

	else
		-- 从StartCopy切换到Copying状态
		self.updateState = UpdateState.Copying

		local function deleteFiles()
			local deletePaths = {}
			for k,v_file in pairs(self.deleteList) do
				local fileName = GetFixedPath(v_file.name)
				table.insert(deletePaths, fileName)
			end
			local paths = System.Collections.Generic.List_string.New()
			for i,v in ipairs(deletePaths) do
				paths:Add(v)
			end
			DFileUtil.DeleteFilesProgress(paths, function (fileName)
				self.ui:Deleted(fileName)
			end, function (success)
				if success then
					Restart()
				else
					self.updateState = UpdateState.UpdateFailed
					LuaLogger.e("Delete Failed")
					self:Failed()
					-- todo
				end
			end)
		end

		local function copyFileList()
			local success = true
			if DFileUtil.FileExists(downloadUpdateFile) == true then
				success = DFileUtil.CopyFile(downloadUpdateFile, originFileList, true)
			end
			if success == true then
				self.ui:StartDelete(self.deleteList)
				
				-- 执行完这个步骤后，将状态设置为UpdateFinished
				self.updateState = UpdateState.UpdateFinished
				DFileUtil.DeleteDir(downloadUpdateDir)
				PlayerPrefs.SetInt(VersionCodeKey, self.serverCode)
				PlayerPrefs.Save()
				SetFirstScriptDowned(1)

				deleteFiles()
			else
				self.updateState = UpdateState.UpdateFailed
				LuaLogger.e("Copy Filelist %s failed")
				--self:Failed()
			end
			
		end

		local function copyBundle()
			DFileUtil.CopyDirProgress(downloadUpdateBundleDir, updateMgr.BundlePath, "*.*", function (fileName)
				LuaLogger.ds("%s copied", fileName)
				self.ui:Copyed(fileName)
			end,

			function (success)
				if success then
					copyFileList()
				else
					self.updateState = UpdateState.UpdateFailed
					LuaLogger.e("Copy Bundle files failed")
					self:Failed()
					-- todo
				end
			end)
		end

		local function copyScript()
			DFileUtil.CopyDirProgress(downloadUpdateScriptDir, updateMgr.LuaPath, "*.*", function (fileName)
				LuaLogger.ds("%s copied", fileName)
				self.ui:Copyed(fileName)
			end,

			function (success)
				if success then
					copyBundle()
				else
					self.updateState = UpdateState.UpdateFailed
					LuaLogger.e("Copy Script files failed")
					self:Failed()
					-- todo
				end
			end)
		end
		-- 进行文件copy
		self.ui:StartCopy()
		copyScript()
		
	end
end

function CheckState:exit()
    print(string.format("CheckState %s exit", self.name))  
end

return CheckState