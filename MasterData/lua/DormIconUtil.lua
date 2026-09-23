DormIconUtil = {}

local this = DormIconUtil

-- 复制主题图片到本地
function this.CopyToLocal()

end

function this.SetIcon(icon, fileName, isSys)
    if (icon == nil or icon.activeSelf == false) then
        return
    end
    if (StringUtil:IsEmpty(fileName)) then
        ResUtil:LoadBigImg(icon, "UIs/Dorm/bg1/bg", true) -- todo 
    elseif (isSys) then
        ResUtil.Theme:Load(icon, fileName .. "/" .. fileName, true)
    else
        local dormThemeIcon = ComUtil.GetCom(icon, "DormThemeIcon")
        if (dormThemeIcon) then
            dormThemeIcon:SetByLocal(fileName, function(b)
                if (not b) then
                    this.DownAndLoad(dormThemeIcon, fileName)
                end
            end)
        end
    end
end

function this.DownAndLoad(dormThemeIcon, fileName)
    local url = ActivityMgr:GetDormDownAddress() .. fileName
    CSAPI.GetServerInfo(url, function(str)
        if str then
            local isLoad = dormThemeIcon:SaveAndLoad(fileName, str)
            if (not isLoad) then
                -- todo 
            end
        end
    end)
end

-- 截图： 升级、改变家具、使用主题 回调时截图 ; 保存主题 发送时截图 
function this.Screenshot_Do(dormScreenshot, cameraGo, fileName, needSmall)
    dormScreenshot:DO(cameraGo, fileName, this.DoCallBack, needSmall)
end

-- 截图完成-》上传
function this.DoCallBack(fileName, dataStr)
    local _data = {}
    _data.op = "write"
    _data.file_name = fileName
    _data.res_dir = GetCurrentServer().resDir
    _data.data = dataStr
    _data.module = "dorm"
    _data.gmaccount = "mega_client"
    _data.logPwd = "client_pwd"
    local s = Json.Encode(_data)
    CSAPI.PostUpload(ActivityMgr:GetDormUploadAddress(), s)
end

--移除截图
function this.RemoveScreenshot(fileName)
	local _data = {}
    _data.op = "del"
    _data.file_name = fileName
    _data.res_dir = GetCurrentServer().resDir
    _data.data = dataStr
    _data.module = "dorm"
    _data.gmaccount = "mega_client"
    _data.logPwd = "client_pwd"
    local s = Json.Encode(_data)
    CSAPI.PostUpload(ActivityMgr:GetDormUploadAddress(), s)
end

return this
