-- 角色同调工具
RoleUniteUtil = {}
local this = RoleUniteUtil

-- 获取标签内容
function this:GetStrs(cfgCard)
    local strs = {}
    local contents = {}
    if (cfgCard) then
        local uniteLabels = cfgCard.uniteLabel
        for _, info in pairs(uniteLabels) do
            local cfg = Cfgs.CfgUniteLabel:GetByID(info[1])
            local condition = LanguageMgr:GetByID(cfg.cfgType == 1 and 4048 or 4069)
            local strInfo = {
                strStart = "",
                content = "",
                strEnd = ""
            }
            if (#info[2] > 0) then
                local str = ""
                for k, m in ipairs(info[2]) do
                    if (k < #info[2]) then
                        strInfo.content = strInfo.content .. condition
                    end

                    if (cfg.key == "nClass") then -- 分队
                        strInfo = self:SetInfo(strInfo, Cfgs.CfgTeamEnum:GetByID(m).sName, 4054, 4055)
                    elseif (cfg.key == "sBelonging") then -- 所属					
                        strInfo = self:SetInfo(strInfo, Cfgs.CfgBelonging:GetByID(m).sName, 4056, 4057)
                    elseif (cfg.key == "sSex") then -- 性别
                        strInfo = self:SetInfo(strInfo, Cfgs.CfgGenDerEnum:GetByID(m).sName, 4058, 4059)
                    elseif (cfg.key == "career") then -- 护甲类型
                        local _ids = {1027, 1028, 1029}
                        strInfo = self:SetInfo(strInfo, LanguageMgr:GetByID(_ids[m]), 4060, 4061)
                        -- strInfo =self:SetInfo(strInfo, Cfgs.CfgGenDerEnum:GetByID(m), 4058, 4059)
                    elseif (cfg.key == "pos_enum") then -- 定位
                        strInfo = self:SetInfo(strInfo, Cfgs.CfgRolePosEnum:GetByID(m).sName, 4062, 4063)
                    elseif (cfg.key == "sBirthPlace") then -- 出身
                        strInfo = self:SetInfo(strInfo, Cfgs.CfgTerritoryEnum:GetByID(m).sName, 4064, 4065)
                    elseif (cfg.key == "sBloodType") then -- 血型
                        strInfo = self:SetInfo(strInfo, m, 4066, 4067)
                    elseif (cfg.key == "sPhysicalAbi") then -- 身体素质
                        strInfo = self:SetInfo(strInfo, m, 4068, 4069)
                    elseif (cfg.key == "sTechniqueAbi") then -- 战斗技巧
                        strInfo = self:SetInfo(strInfo, m, 4070, 4071)
                    elseif (cfg.key == "sMoraleAbi") then -- 战斗意志
                        strInfo = self:SetInfo(strInfo, m, 4072, 4073)
                    elseif (cfg.key == "sHarmonyAbi") then -- 队伍协调
                        strInfo = self:SetInfo(strInfo, m, 4074, 4075)
                    elseif (cfg.key == "sHeight") then -- 身高
                        strInfo.strStart = ""
                        if (m[1] < 0 and m[2] < 0) then
                            strInfo.content = strInfo.content .. LanguageMgr:GetByID(1040)
                        elseif (m[1] < 0) then
                            strInfo.content = strInfo.content .. string.format(LanguageMgr:GetByID(4066), m[2])
                        elseif (m[2] < 0) then
                            strInfo.content = strInfo.content .. string.format(LanguageMgr:GetByID(4067), m[1])
                        else
                            strInfo.content = strInfo.content .. string.format(LanguageMgr:GetByID(4068), m[1], m[2])
                        end
                        strInfo.strEnd = ""
                    elseif (cfg.key == "") then -- hp
                        strInfo.strStart = ""
                        if (m[1] < 0 and m[2] < 0) then
                            strInfo.content = strInfo.content .. LanguageMgr:GetByID(1040)
                        elseif (m[1] < 0) then
                            strInfo.content = strInfo.content .. string.format(LanguageMgr:GetByID(4071), m[2])
                        elseif (m[2] < 0) then
                            strInfo.content = strInfo.content .. string.format(LanguageMgr:GetByID(4072), m[1])
                        else
                            strInfo.content = strInfo.content .. string.format(LanguageMgr:GetByID(4073), m[1], m[2])
                        end
                        strInfo.strEnd = ""
                    end
                    table.insert(contents,strInfo.content)
                end
                str = strInfo.strStart .. StringUtil:SetByColor(strInfo.content, "ffc146") .. strInfo.strEnd
                table.insert(strs, str)
            end
        end
    end
    return strs,contents
end

function this:SetInfo(_info, content, startID, contentID, endID)
    startID = startID or 0
    contentID = contentID or 0
    endID = endID or 0
    _info.strStart = LanguageMgr:GetByID(startID)
    local _str = contentID > 0 and string.format(LanguageMgr:GetByID(contentID), content) or content
    _info.content = _info.content .. _str
    _info.strEnd = LanguageMgr:GetByID(endID)
    return _info
end

return this
