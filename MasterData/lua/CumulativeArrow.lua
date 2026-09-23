--小额付费箭头 1:向左 2/默认：向右 3：向上 4：向下
function Refresh(type)
    --上下左右
    local x,y,z=0,0,0;
    if type==1 then
        y=180;
    elseif type==3 then
        z=90;
    elseif type==4 then
        z=-90
    end
    CSAPI.SetAngle(gameObject,x,y,z)
end