local d=nil;
local activeId=nil;
local clickImg=nil;

function Awake()
    clickImg=ComUtil.GetCom(gameObject,"Image");
end

function Refresh(_data,_activeId)
    d=_data;
    activeId=_activeId
    if d then 
        local state=d:GetState()
        local imgName,imgName2="",nil;
        CSAPI.SetGOActive(bg,state~=1);
        CSAPI.SetGOActive(icon,state~=2);
        CSAPI.SetGOActive(redNode,state==2);
        CSAPI.SetGOActive(stateImg,state~=1);
        CSAPI.SetGOActive(effect,state==2);
        UIUtil:SetRedPoint(redNode, state==2, 0, 0, 0)
        if state==1 then
            imgName="img_05_03";
        elseif state==2 then
            imgName="img_05_01";
            imgName2="img_06_02";
        elseif state==3 then
            imgName="img_05_02";
            imgName2="img_06_01";
        end
        clickImg.raycastTarget=state~=3
        CSAPI.LoadImg(icon,string.format("UIs/PuzzleActivity/%s.png",imgName),true,nil,true)
        if imgName2 then
            CSAPI.LoadImg(stateImg,string.format("UIs/PuzzleActivity/%s.png",imgName2),true,nil,true)
        end
        local pos=d:GetPos();
        CSAPI.SetAnchor(gameObject,pos[1],pos[2]);
    end
end

--领取奖励
function OnClick()
    if d and activeId  then
        if d:GetState()==2 then
            ActivePuzzleProto:GetReward(activeId,d:GetIdx())
        else
            --显示预览奖励
            local info=d:GetRewardShow();
            if info then
                local goods=BagMgr:GetFakeData(info[1][1]);
                if goods then
                    CSAPI.OpenView("GoodsFullInfo",{data=goods})
                end
            end
        end
    end
end