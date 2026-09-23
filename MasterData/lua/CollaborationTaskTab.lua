local data=nil
local isOn=false;
function Refresh(_d,elseData)
    data=_d;
    if data then
        CSAPI.SetText(txtName,LanguageMgr:GetByID(data.desc));
        if elseData then
            CSAPI.SetGOActive(onTween,data.id==elseData);
            CSAPI.SetGOActive(offTween,data.id~=elseData);
            isOn=data.id==elseData
        end
        SetRed();
    end
end

function SetRed()
    local isRed=false;
    if data then
        local currActivity=CollaborationMgr:GetCurrInfo();
        if currActivity and currActivity:IsLimitFull()~=true then
            local taskInfo=MissionMgr:GetCollaborationData(eTaskType.RegressionBind,data.id);
            if taskInfo and #taskInfo>0 then
                for k,v in ipairs(taskInfo) do
                    if v:IsGet()~=true and v:IsFinish() then
                        isRed=true;
                        break;
                    end
                end
            end
        end
    end
    UIUtil:SetRedPoint(gameObject,isRed,96,22);
end

function OnClickTab()
    EventMgr.Dispatch(EventType.Collaboration_TaskTab_Change,data.id);
end