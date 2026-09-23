
--_d:PetArchiveRewardInfo
function Refresh(_d)
    this.data=_d;
    if this.data then
        --判断是否领取过
        local rewardList=GridUtil.GetGridObjectDatas2(_d:GetReward())
        if rewardList then
            rewardList[1]:GetIconLoader():Load(icon,rewardList[1]:GetIcon());
            CSAPI.SetScale(icon,0.6,0.6,0.6);
            CSAPI.SetText(txtNum,tostring(rewardList[1]:GetCount()));
        end
        local state=this.data:GetState(); 
        if state==3 then
            CSAPI.SetGOActive(frame,false);
            CSAPI.SetGOActive(redPoint,false);
            CSAPI.SetGOActive(overObj,true);
            CSAPI.SetImgColor(icon,255,255,255,122);
            CSAPI.SetImgColor(numObj,255,255,255,122);
        elseif state==2 then
            CSAPI.SetGOActive(frame,true);
            CSAPI.SetGOActive(redPoint,true);
            CSAPI.SetGOActive(overObj,false);
            CSAPI.SetImgColor(icon,255,255,255,255);
            CSAPI.SetImgColor(numObj,255,255,255,255);
        elseif state==1 then
            CSAPI.SetGOActive(frame,false);
            CSAPI.SetGOActive(redPoint,false);
            CSAPI.SetGOActive(overObj,false);
            CSAPI.SetImgColor(icon,255,255,255,122);
            CSAPI.SetImgColor(numObj,255,255,255,122);
        end
    end
end

function InitNull()
    this.data=nil;
    this.cb=nil;
    CSAPI.SetGOActive(frame,false);
    CSAPI.SetGOActive(redPoint,false);
    CSAPI.SetGOActive(overObj,false);
end

function SetIcon(resName)
    if resName then
        ResUtil.IconGoods:Load(icon, resName .. "")
    end
end

function SetClickCB(_cb)
    this.cb=_cb
end

function OnClick()
    if this.cb then
        this.cb(this)
    end
end