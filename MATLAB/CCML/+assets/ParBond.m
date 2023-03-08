classdef ParBond
% **********************************************************************************************
%% THIS class will model properties, behaviours and values of a Par Bond financial instrument
%
% Independent Properties:
%   face:          (1,1) single representing the face value of the bond
%   tenor:         (1,1) single representing the time, in years, until the bond matures
%   numCoups:      (1,1) single representing the # of coupons per year the bond generates
%   couponRate:    (1,1) single representing the rate paid on each coupon generated
%
% Dependent Properties:
%   numPeriods:    (1,1) single representing the # periods bond is inforce
%   isZcb:         (1,1) logical representing whether or not the bond is a zero-coupon bond
%   couponAmt:     (1,1) single representing the amount of each coupon generated
%   redemptionAmt: (1,1) single representing the component of the final amount attributable to 
%                  the maturing
%   couponCf:      (n,1) single representing the series of coupons generated by the bond
%   yield:         (1,1) single representing the yield of the bond
%
%
% ********************************************************************************************** 
properties
    face          (1,1) single;
    tenor         (1,1) single;
    numCoups      (1,1) single;
    couponRate    (1,1) single;
end

properties (Dependent)
    numPeriods    (1,1) single;
    isZcb         (1,1) logical;
    couponAmt     (1,1) single;
    redemptionAmt (1,1) single;
    couponCf      (:,1) signle;
    maturityCf    (:,1) single;
    totalCf       (:,1) single;
    yield         (1,1) single;
end
    
methods
    %% Constructor
    function this = ParBond(face, tenor, numCoups, couponRate)
        % Input Validation
        arguments
            face       {mustBeNonnegative}                      = 100;
            tenor      {mustBePositive}                         = 5;
            numCoups   {mustBeMember(numCoups, [0,1,2,4,6,12])} = 2;
            couponRate {mustBeNumeric}                          = 0.01;
        end
        
        % apply input arguments to class properties
        this = manips.addVarsToObj(this, face, tenor, numCoups, couponRate);
    end
    
    %% Getters
    % numPeriods getter
    function val = get.numPeriods(this); val = max(this.tenor * this.numCoups, 1); end
    
    % isZcb getter
    function val = get.isZcb(this); val = (this.numCoups == 0); end
    
    % couponAmt getter
    function val = get.couponAmt(this); val = this.face * this.couponRate; end
    
    % redemptionAmt getter
    function val = get.redemptionAmt(this); val = this.face; end
    
    % couponCf getter
    function val = get.couponCf(this)
        val = zeros(this.numPeriods, 1) + (this.couponAmt * ~this.isZcb); 
    end
    
    % maturityCf getter
    function val = get.maturityCf(this)
       val = zeros(this.numPeriods, 1); 
       val(end) = this.redemptionAmt + (this.couponAmt * this.isZcb);
    end
    
    % totalCf getter
    function val = get.totalCf(this)
       val = this.couponCf + this.maturityCf; 
    end
end
end

