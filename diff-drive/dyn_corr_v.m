function dpv = dyn_corr_v(pv, gv)
global al btv;
dpv = al*pv + btv*gv;
