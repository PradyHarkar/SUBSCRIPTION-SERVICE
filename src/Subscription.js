import React, { useState } from 'react';

function Subscription() {
  const [plan, setPlan] = useState('monthly');

  return (
    <section>
      <h2>Choose Your Subscription Plan</h2>
      <label>
        <input 
          type="radio" 
          name="plan" 
          value="monthly" 
          checked={plan === 'monthly'} 
          onChange={() => setPlan('monthly')} 
        />
        Monthly - AUD 149
      </label>
      <label>
        <input 
          type="radio" 
          name="plan" 
          value="yearly" 
          checked={plan === 'yearly'} 
          onChange={() => setPlan('yearly')} 
        />
        Yearly - AUD 1499 (Save $349 annually)
      </label>
      <p>
        Selected Plan: <b>{plan === 'monthly' ? "Monthly" : "Yearly"}</b> 
      </p>
      <button>Subscribe Now</button>
    </section>
  );
}

export default Subscription;