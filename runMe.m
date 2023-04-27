% simulate the model
mdl = 'model';
load_system(mdl);
cs = getActiveConfigSet(mdl);
simOut = sim(mdl, cs);

x = find(simOut.yout, 'x');
y = find(simOut.yout, 'y');
xdot = find(simOut.yout, 'xdot');
ydot = find(simOut.yout, 'ydot');

mdlWks = get_param(mdl, 'ModelWorkspace');
V = getVariable(mdlWks, 'V');

% plot the trajectory
figure('color', 'white');
tiledlayout(3, 2);

nexttile([3 1]);
stairs(x.Values.Data, y.Values.Data);
xlabel('x [m]');
ylabel('y [m]');
grid('minor');

nexttile;
hold('on');
stairs(x.Values.Time, x.Values.Data);
stairs(y.Values.Time, y.Values.Data);
xlabel('time [s]');
ylabel('[m]');
legend({'$x$' '$y$'}, 'Interpreter', 'latex');
grid('minor');

nexttile;
hold('on');
stairs(xdot.Values.Time, xdot.Values.Data);
stairs(ydot.Values.Time, ydot.Values.Data);
xlabel('time [s]');
ylabel('[m/s]');
legend({'$\dot{x}$' '$\dot{y}$'}, 'Interpreter', 'latex');
grid('minor');

% verify the constant speed along the arc
nexttile;
hold('on');
yline(V.Value);
vel = sqrt(xdot.Values.Data.^2 + ydot.Values.Data.^2);
stairs(xdot.Values.Time, vel);
ylim([0.9 1.1]*V.Value);
xlabel('time [s]');
ylabel('[m/s]');
legend({'$V$' '$\sqrt{\dot{x}^2+\dot{y}^2}$'}, 'Interpreter', 'latex');
grid('minor');
